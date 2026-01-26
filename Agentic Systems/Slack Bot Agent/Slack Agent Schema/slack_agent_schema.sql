-- Slack Agent Database Schema
-- Generated: 2026-01-26
-- Database: PostgreSQL

-- ============================================
-- CORE INFRASTRUCTURE TABLES
-- ============================================

CREATE TABLE workspaces (
    workspace_id VARCHAR(255) PRIMARY KEY,
    workspace_name VARCHAR(255) NOT NULL,
    domain VARCHAR(255),
    installed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    plan_type VARCHAR(50) CHECK (plan_type IN ('Free', 'Pro', 'Enterprise')),
    settings JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
    user_id VARCHAR(255) PRIMARY KEY,
    workspace_id VARCHAR(255) REFERENCES workspaces(workspace_id) ON DELETE CASCADE,
    slack_user_id VARCHAR(255) NOT NULL,
    display_name VARCHAR(255),
    email VARCHAR(255),
    timezone VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role VARCHAR(50) CHECK (role IN ('Member', 'Manager', 'Admin', 'Bot')),
    last_active TIMESTAMP,
    preferences JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(workspace_id, slack_user_id)
);

CREATE TABLE channels (
    channel_id VARCHAR(255) PRIMARY KEY,
    workspace_id VARCHAR(255) REFERENCES workspaces(workspace_id) ON DELETE CASCADE,
    slack_channel_id VARCHAR(255) NOT NULL,
    channel_name VARCHAR(255),
    channel_type VARCHAR(50) CHECK (channel_type IN ('Public', 'Private', 'DM')),
    is_monitored BOOLEAN DEFAULT FALSE,
    monitoring_config JSONB,
    standup_enabled BOOLEAN DEFAULT FALSE,
    summary_enabled BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(workspace_id, slack_channel_id)
);

-- ============================================
-- COMMUNICATION TRACKING TABLES
-- ============================================

CREATE TABLE threads (
    thread_id VARCHAR(255) PRIMARY KEY,
    channel_id VARCHAR(255) REFERENCES channels(channel_id) ON DELETE CASCADE,
    slack_thread_ts VARCHAR(255) NOT NULL,
    started_at TIMESTAMP,
    last_activity TIMESTAMP,
    message_count INTEGER DEFAULT 0,
    participant_count INTEGER DEFAULT 0,
    has_summary BOOLEAN DEFAULT FALSE,
    status VARCHAR(50) CHECK (status IN ('Active', 'Idle', 'Resolved', 'Archived')),
    has_decision BOOLEAN DEFAULT FALSE,
    has_tasks BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(channel_id, slack_thread_ts)
);

CREATE TABLE messages (
    message_id VARCHAR(255) PRIMARY KEY,
    thread_id VARCHAR(255) REFERENCES threads(thread_id) ON DELETE CASCADE,
    user_id VARCHAR(255) REFERENCES users(user_id) ON DELETE SET NULL,
    slack_message_ts VARCHAR(255) NOT NULL,
    message_text TEXT,
    sent_at TIMESTAMP,
    message_type VARCHAR(50) CHECK (message_type IN ('User Message', 'Bot Message', 'System Message', 'Agent Response')),
    has_mentions BOOLEAN DEFAULT FALSE,
    has_attachments BOOLEAN DEFAULT FALSE,
    embedding_vector VECTOR(1536), -- For pgvector extension
    context_summary TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(thread_id, slack_message_ts)
);

-- ============================================
-- ASYNC COORDINATION TABLES
-- ============================================

CREATE TABLE standups (
    standup_id VARCHAR(255) PRIMARY KEY,
    channel_id VARCHAR(255) REFERENCES channels(channel_id) ON DELETE CASCADE,
    standup_date DATE NOT NULL,
    status VARCHAR(50) CHECK (status IN ('Scheduled', 'In Progress', 'Completed', 'Cancelled')),
    triggered_at TIMESTAMP,
    completed_at TIMESTAMP,
    response_count INTEGER DEFAULT 0,
    summary TEXT,
    questions JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(channel_id, standup_date)
);

CREATE TABLE standup_responses (
    response_id VARCHAR(255) PRIMARY KEY,
    standup_id VARCHAR(255) REFERENCES standups(standup_id) ON DELETE CASCADE,
    user_id VARCHAR(255) REFERENCES users(user_id) ON DELETE CASCADE,
    submitted_at TIMESTAMP,
    response_text TEXT,
    status VARCHAR(50) CHECK (status IN ('Pending', 'Submitted', 'Skipped', 'Late')),
    what_worked_on TEXT,
    whats_next TEXT,
    blockers TEXT,
    has_blockers BOOLEAN DEFAULT FALSE,
    follow_up_needed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(standup_id, user_id)
);

-- ============================================
-- TASK & DECISION MANAGEMENT TABLES
-- ============================================

CREATE TABLE tasks (
    task_id VARCHAR(255) PRIMARY KEY,
    thread_id VARCHAR(255) REFERENCES threads(thread_id) ON DELETE SET NULL,
    assigned_to VARCHAR(255) REFERENCES users(user_id) ON DELETE SET NULL,
    created_by VARCHAR(255) REFERENCES users(user_id) ON DELETE SET NULL,
    task_description TEXT NOT NULL,
    status VARCHAR(50) CHECK (status IN ('Open', 'In Progress', 'Blocked', 'Completed', 'Cancelled')),
    priority VARCHAR(50) CHECK (priority IN ('Low', 'Medium', 'High', 'Urgent')),
    due_date DATE,
    completed_at TIMESTAMP,
    is_blocked BOOLEAN DEFAULT FALSE,
    last_reminder TIMESTAMP,
    reminder_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE decisions (
    decision_id VARCHAR(255) PRIMARY KEY,
    thread_id VARCHAR(255) REFERENCES threads(thread_id) ON DELETE SET NULL,
    decision_text TEXT NOT NULL,
    made_at TIMESTAMP,
    decision_type VARCHAR(50) CHECK (decision_type IN ('Technical', 'Product', 'Process', 'Resource', 'Strategic')),
    context TEXT,
    impact VARCHAR(50) CHECK (impact IN ('Low', 'Medium', 'High', 'Critical')),
    stakeholders TEXT,
    is_implemented BOOLEAN DEFAULT FALSE,
    related_tasks JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- AGENT OPERATIONS TABLES
-- ============================================

CREATE TABLE summaries (
    summary_id VARCHAR(255) PRIMARY KEY,
    thread_id VARCHAR(255) REFERENCES threads(thread_id) ON DELETE CASCADE,
    channel_id VARCHAR(255) REFERENCES channels(channel_id) ON DELETE SET NULL,
    summary_text TEXT NOT NULL,
    summary_type VARCHAR(50) CHECK (summary_type IN ('Thread Summary', 'Channel Summary', 'Daily Digest', 'Weekly Report')),
    key_points TEXT,
    action_items TEXT,
    decisions_made TEXT,
    open_questions TEXT,
    posted_to_slack BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reminders (
    reminder_id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255) REFERENCES users(user_id) ON DELETE CASCADE,
    task_id VARCHAR(255) REFERENCES tasks(task_id) ON DELETE CASCADE,
    thread_id VARCHAR(255) REFERENCES threads(thread_id) ON DELETE SET NULL,
    reminder_type VARCHAR(50) CHECK (reminder_type IN ('Standup Reminder', 'Task Follow-up', 'Question Follow-up', 'Escalation', 'General Nudge')),
    reminder_text TEXT,
    scheduled_for TIMESTAMP NOT NULL,
    sent_at TIMESTAMP,
    status VARCHAR(50) CHECK (status IN ('Pending', 'Sent', 'Acknowledged', 'Dismissed', 'Failed')),
    attempts INTEGER DEFAULT 0,
    escalation_level VARCHAR(50) CHECK (escalation_level IN ('Normal', 'Warning', 'Urgent')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

-- Workspace indexes
CREATE INDEX idx_workspaces_active ON workspaces(is_active);

-- User indexes
CREATE INDEX idx_users_workspace ON users(workspace_id);
CREATE INDEX idx_users_slack_id ON users(slack_user_id);
CREATE INDEX idx_users_active ON users(is_active);

-- Channel indexes
CREATE INDEX idx_channels_workspace ON channels(workspace_id);
CREATE INDEX idx_channels_monitored ON channels(is_monitored);
CREATE INDEX idx_channels_standup ON channels(standup_enabled);

-- Thread indexes
CREATE INDEX idx_threads_channel ON threads(channel_id);
CREATE INDEX idx_threads_status ON threads(status);
CREATE INDEX idx_threads_last_activity ON threads(last_activity);

-- Message indexes
CREATE INDEX idx_messages_thread ON messages(thread_id);
CREATE INDEX idx_messages_user ON messages(user_id);
CREATE INDEX idx_messages_sent_at ON messages(sent_at);
-- Vector similarity search (requires pgvector extension)
CREATE INDEX idx_messages_embedding ON messages USING ivfflat (embedding_vector vector_cosine_ops);

-- Standup indexes
CREATE INDEX idx_standups_channel ON standups(channel_id);
CREATE INDEX idx_standups_date ON standups(standup_date);
CREATE INDEX idx_standups_status ON standups(status);

-- Standup response indexes
CREATE INDEX idx_standup_responses_standup ON standup_responses(standup_id);
CREATE INDEX idx_standup_responses_user ON standup_responses(user_id);
CREATE INDEX idx_standup_responses_status ON standup_responses(status);

-- Task indexes
CREATE INDEX idx_tasks_assigned ON tasks(assigned_to);
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_priority ON tasks(priority);
CREATE INDEX idx_tasks_due_date ON tasks(due_date);

-- Decision indexes
CREATE INDEX idx_decisions_thread ON decisions(thread_id);
CREATE INDEX idx_decisions_type ON decisions(decision_type);
CREATE INDEX idx_decisions_impact ON decisions(impact);

-- Summary indexes
CREATE INDEX idx_summaries_thread ON summaries(thread_id);
CREATE INDEX idx_summaries_type ON summaries(summary_type);
CREATE INDEX idx_summaries_created ON summaries(created_at);

-- Reminder indexes
CREATE INDEX idx_reminders_user ON reminders(user_id);
CREATE INDEX idx_reminders_scheduled ON reminders(scheduled_for);
CREATE INDEX idx_reminders_status ON reminders(status);

-- ============================================
-- FUNCTIONS AND TRIGGERS
-- ============================================

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply trigger to tables with updated_at
CREATE TRIGGER update_workspaces_updated_at BEFORE UPDATE ON workspaces FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_channels_updated_at BEFORE UPDATE ON channels FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_threads_updated_at BEFORE UPDATE ON threads FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_standups_updated_at BEFORE UPDATE ON standups FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_standup_responses_updated_at BEFORE UPDATE ON standup_responses FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON tasks FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_decisions_updated_at BEFORE UPDATE ON decisions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_reminders_updated_at BEFORE UPDATE ON reminders FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
