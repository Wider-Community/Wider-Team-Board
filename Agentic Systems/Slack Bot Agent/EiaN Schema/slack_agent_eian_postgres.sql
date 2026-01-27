-- EiaN Architecture Implementation for PostgreSQL
-- Entity in a Network: Space-Nodes-Context Model
-- Version: 1.0.0
-- Date: 2026-01-26

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "vector";  -- For embeddings

-- ============================================
-- SPACE LAYER - Containers and Boundaries
-- ============================================

CREATE TABLE spaces (
    space_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    space_type VARCHAR(50) NOT NULL CHECK (space_type IN ('workspace', 'channel', 'thread', 'time_window')),
    parent_space_id UUID REFERENCES spaces(space_id) ON DELETE CASCADE,
    name VARCHAR(255),
    external_id VARCHAR(255), -- Slack IDs
    metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
    status VARCHAR(50) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Indexes
    INDEX idx_spaces_type (space_type),
    INDEX idx_spaces_parent (parent_space_id),
    INDEX idx_spaces_external (external_id),
    INDEX idx_spaces_metadata USING GIN (metadata)
);

-- Space hierarchy path for efficient ancestor queries
CREATE TABLE space_paths (
    ancestor_id UUID REFERENCES spaces(space_id) ON DELETE CASCADE,
    descendant_id UUID REFERENCES spaces(space_id) ON DELETE CASCADE,
    depth INTEGER NOT NULL,
    PRIMARY KEY (ancestor_id, descendant_id),
    INDEX idx_space_paths_depth (depth)
);

-- ============================================
-- NODE LAYER - Entities with Properties
-- ============================================

CREATE TABLE nodes (
    node_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    node_type VARCHAR(50) NOT NULL CHECK (node_type IN ('agent', 'message', 'task', 'decision', 'event', 'summary')),
    space_id UUID NOT NULL REFERENCES spaces(space_id) ON DELETE CASCADE,

    -- Core properties (type-specific, stored as JSONB)
    identity JSONB,          -- For agents: slack_user_id, display_name, email
    content JSONB,           -- For messages, tasks, decisions: main content
    attributes JSONB,        -- Type-specific attributes
    state JSONB,             -- Current state
    semantics JSONB,         -- Embeddings, intent, sentiment
    temporal JSONB,          -- Timestamps: created_at, due_date, etc.
    tracking JSONB,          -- Metrics: reminder_count, etc.

    -- Metadata
    metadata JSONB NOT NULL DEFAULT '{}'::jsonb,

    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Indexes
    INDEX idx_nodes_type (node_type),
    INDEX idx_nodes_space (space_id),
    INDEX idx_nodes_identity USING GIN (identity),
    INDEX idx_nodes_content USING GIN (content),
    INDEX idx_nodes_attributes USING GIN (attributes),
    INDEX idx_nodes_state USING GIN (state)
);

-- Separate table for semantic embeddings (for vector search)
CREATE TABLE node_embeddings (
    node_id UUID PRIMARY KEY REFERENCES nodes(node_id) ON DELETE CASCADE,
    embedding VECTOR(1536) NOT NULL,  -- OpenAI text-embedding-3-small dimension
    model_version VARCHAR(50) DEFAULT 'text-embedding-3-small',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Vector similarity index
    INDEX idx_embeddings_vector USING ivfflat (embedding vector_cosine_ops)
);

-- ============================================
-- CONTEXT LAYER - Relationships and Metadata
-- ============================================

CREATE TABLE contexts (
    context_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    context_type VARCHAR(50) NOT NULL CHECK (context_type IN ('connection', 'annotation', 'state', 'history')),

    -- Connection fields
    from_node_id UUID REFERENCES nodes(node_id) ON DELETE CASCADE,
    to_node_id UUID REFERENCES nodes(node_id) ON DELETE CASCADE,
    connection_type VARCHAR(50),
    weight FLOAT DEFAULT 1.0,

    -- Annotation fields
    target_node_id UUID REFERENCES nodes(node_id) ON DELETE CASCADE,
    annotation_type VARCHAR(50),
    key VARCHAR(255),
    value JSONB,

    -- State tracking fields
    state_type VARCHAR(50),
    previous_value JSONB,
    current_value JSONB,

    -- History fields
    space_id UUID REFERENCES spaces(space_id) ON DELETE CASCADE,
    event_sequence UUID[],
    window_start TIMESTAMP,
    window_end TIMESTAMP,

    -- Common fields
    properties JSONB DEFAULT '{}'::jsonb,
    created_by UUID REFERENCES nodes(node_id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Indexes
    INDEX idx_contexts_type (context_type),
    INDEX idx_contexts_from (from_node_id),
    INDEX idx_contexts_to (to_node_id),
    INDEX idx_contexts_target (target_node_id),
    INDEX idx_contexts_connection_type (connection_type),
    INDEX idx_contexts_space (space_id),
    INDEX idx_contexts_properties USING GIN (properties)
);

-- ============================================
-- MATERIALIZED VIEWS FOR COMMON QUERIES
-- ============================================

-- View: Active tasks per agent
CREATE MATERIALIZED VIEW mv_agent_tasks AS
SELECT 
    a.node_id as agent_id,
    a.identity->>'display_name' as agent_name,
    t.node_id as task_id,
    t.content->>'description' as task_description,
    t.state->>'status' as status,
    t.state->>'priority' as priority,
    (t.temporal->>'due_date')::timestamp as due_date
FROM nodes a
JOIN contexts c ON c.to_node_id = a.node_id AND c.connection_type = 'assigned_to'
JOIN nodes t ON t.node_id = c.from_node_id AND t.node_type = 'task'
WHERE a.node_type = 'agent'
  AND t.state->>'status' IN ('open', 'in_progress');

CREATE INDEX idx_mv_agent_tasks_agent ON mv_agent_tasks(agent_id);
CREATE INDEX idx_mv_agent_tasks_status ON mv_agent_tasks(status);

-- View: Thread activity summary
CREATE MATERIALIZED VIEW mv_thread_activity AS
SELECT 
    s.space_id,
    s.name as thread_name,
    COUNT(DISTINCT n.node_id) as message_count,
    COUNT(DISTINCT n.content->>'author_node_id') as participant_count,
    MAX((n.metadata->>'sent_at')::timestamp) as last_activity,
    MIN((n.metadata->>'sent_at')::timestamp) as first_activity
FROM spaces s
JOIN nodes n ON n.space_id = s.space_id AND n.node_type = 'message'
WHERE s.space_type = 'thread'
GROUP BY s.space_id, s.name;

CREATE INDEX idx_mv_thread_activity_space ON mv_thread_activity(space_id);

-- ============================================
-- HELPER FUNCTIONS
-- ============================================

-- Function: Get space hierarchy
CREATE OR REPLACE FUNCTION get_space_ancestors(target_space_id UUID)
RETURNS TABLE(space_id UUID, space_type VARCHAR, name VARCHAR, depth INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT s.space_id, s.space_type, s.name, sp.depth
    FROM spaces s
    JOIN space_paths sp ON sp.ancestor_id = s.space_id
    WHERE sp.descendant_id = target_space_id
    ORDER BY sp.depth;
END;
$$ LANGUAGE plpgsql;

-- Function: Find similar messages by embedding
CREATE OR REPLACE FUNCTION find_similar_messages(
    query_embedding VECTOR(1536),
    similarity_threshold FLOAT DEFAULT 0.7,
    max_results INTEGER DEFAULT 10
)
RETURNS TABLE(node_id UUID, similarity FLOAT, message_text TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        n.node_id,
        1 - (e.embedding <=> query_embedding) as similarity,
        n.content->>'text' as message_text
    FROM nodes n
    JOIN node_embeddings e ON e.node_id = n.node_id
    WHERE n.node_type = 'message'
      AND 1 - (e.embedding <=> query_embedding) >= similarity_threshold
    ORDER BY e.embedding <=> query_embedding
    LIMIT max_results;
END;
$$ LANGUAGE plpgsql;

-- Function: Create connection between nodes
CREATE OR REPLACE FUNCTION create_connection(
    p_from_node_id UUID,
    p_to_node_id UUID,
    p_connection_type VARCHAR,
    p_properties JSONB DEFAULT '{}'::jsonb
)
RETURNS UUID AS $$
DECLARE
    new_context_id UUID;
BEGIN
    INSERT INTO contexts (
        context_type,
        from_node_id,
        to_node_id,
        connection_type,
        properties
    ) VALUES (
        'connection',
        p_from_node_id,
        p_to_node_id,
        p_connection_type,
        p_properties
    ) RETURNING context_id INTO new_context_id;

    RETURN new_context_id;
END;
$$ LANGUAGE plpgsql;

-- Function: Add annotation to node
CREATE OR REPLACE FUNCTION add_annotation(
    p_target_node_id UUID,
    p_annotation_type VARCHAR,
    p_key VARCHAR,
    p_value JSONB,
    p_created_by UUID DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
    new_context_id UUID;
BEGIN
    INSERT INTO contexts (
        context_type,
        target_node_id,
        annotation_type,
        key,
        value,
        created_by
    ) VALUES (
        'annotation',
        p_target_node_id,
        p_annotation_type,
        p_key,
        p_value,
        p_created_by
    ) RETURNING context_id INTO new_context_id;

    RETURN new_context_id;
END;
$$ LANGUAGE plpgsql;

-- Function: Track state change
CREATE OR REPLACE FUNCTION track_state_change(
    p_target_node_id UUID,
    p_state_type VARCHAR,
    p_previous_value JSONB,
    p_current_value JSONB,
    p_changed_by UUID DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
    new_context_id UUID;
BEGIN
    INSERT INTO contexts (
        context_type,
        target_node_id,
        state_type,
        previous_value,
        current_value,
        created_by
    ) VALUES (
        'state',
        p_target_node_id,
        p_state_type,
        p_previous_value,
        p_current_value,
        p_changed_by
    ) RETURNING context_id INTO new_context_id;

    RETURN new_context_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- TRIGGERS
-- ============================================

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER spaces_updated_at BEFORE UPDATE ON spaces
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER nodes_updated_at BEFORE UPDATE ON nodes
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Maintain space hierarchy paths
CREATE OR REPLACE FUNCTION maintain_space_paths()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        -- Insert self-reference
        INSERT INTO space_paths (ancestor_id, descendant_id, depth)
        VALUES (NEW.space_id, NEW.space_id, 0);

        -- Insert paths through parent
        IF NEW.parent_space_id IS NOT NULL THEN
            INSERT INTO space_paths (ancestor_id, descendant_id, depth)
            SELECT ancestor_id, NEW.space_id, depth + 1
            FROM space_paths
            WHERE descendant_id = NEW.parent_space_id;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER spaces_hierarchy_maintenance AFTER INSERT ON spaces
    FOR EACH ROW EXECUTE FUNCTION maintain_space_paths();

-- ============================================
-- EXAMPLE QUERIES
-- ============================================

-- Query 1: Find all tasks assigned to a user
/*
SELECT 
    n.node_id,
    n.content->>'description' as task_description,
    n.state->>'status' as status,
    n.state->>'priority' as priority,
    (n.temporal->>'due_date')::timestamp as due_date
FROM nodes n
JOIN contexts c ON c.from_node_id = n.node_id 
    AND c.context_type = 'connection'
    AND c.connection_type = 'assigned_to'
WHERE n.node_type = 'task'
  AND c.to_node_id = (
      SELECT node_id FROM nodes 
      WHERE node_type = 'agent' 
        AND identity->>'slack_user_id' = 'U12345'
  )
  AND n.state->>'status' IN ('open', 'in_progress')
ORDER BY n.state->>'priority' DESC, (n.temporal->>'due_date')::timestamp;
*/

-- Query 2: Get thread context with messages
/*
SELECT 
    n.node_id,
    n.content->>'text' as message_text,
    (n.metadata->>'sent_at')::timestamp as sent_at,
    a.identity->>'display_name' as author_name
FROM nodes n
JOIN nodes a ON (n.content->>'author_node_id')::uuid = a.node_id
WHERE n.space_id = 'thread_space_id_here'
  AND n.node_type = 'message'
ORDER BY (n.metadata->>'sent_at')::timestamp;
*/

-- Query 3: Semantic search
/*
SELECT * FROM find_similar_messages(
    '[0.1, 0.2, ...]'::vector(1536),  -- Query embedding
    0.7,  -- Similarity threshold
    10    -- Max results
);
*/

-- Query 4: Get decision context
/*
WITH decision_thread AS (
    SELECT space_id FROM nodes WHERE node_id = 'decision_node_id'
)
SELECT 
    n.*
FROM nodes n
WHERE n.space_id = (SELECT space_id FROM decision_thread)
  AND n.node_type = 'message'
ORDER BY (n.metadata->>'sent_at')::timestamp;
*/

-- ============================================
-- REFRESH MATERIALIZED VIEWS
-- ============================================

-- Run periodically or on-demand
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_agent_tasks;
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_thread_activity;
