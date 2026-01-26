# Slack Agent - Detailed Schema Documentation

Comprehensive documentation of all database tables, relationships, and usage patterns.

---

## Table of Contents

1. [Core Infrastructure](#core-infrastructure)
   - [Workspaces](#workspaces)
   - [Users](#users)
   - [Channels](#channels)
2. [Communication Tracking](#communication-tracking)
   - [Threads](#threads)
   - [Messages](#messages)
3. [Async Coordination](#async-coordination)
   - [Standups](#standups)
   - [Standup Responses](#standup-responses)
4. [Task & Decision Management](#task--decision-management)
   - [Tasks](#tasks)
   - [Decisions](#decisions)
5. [Agent Operations](#agent-operations)
   - [Summaries](#summaries)
   - [Reminders](#reminders)

---

## Core Infrastructure

### Workspaces

**Purpose**: Track Slack workspaces where the agent is installed


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| workspace_id | VARCHAR(255) | PRIMARY KEY | Unique workspace identifier |
| workspace_name | VARCHAR(255) | NOT NULL | Human-readable name |
| domain | VARCHAR(255) | | Slack workspace domain |
| installed_at | TIMESTAMP | DEFAULT NOW() | Installation timestamp |
| is_active | BOOLEAN | DEFAULT TRUE | Active status |
| plan_type | VARCHAR(50) | CHECK | Free, Pro, or Enterprise |
| settings | JSONB | | Configuration (JSON) |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation |
| updated_at | TIMESTAMP | AUTO-UPDATE | Last update |

**Relationships**:
- → `users` (one-to-many)
- → `channels` (one-to-many)

**Indexes**:
- `idx_workspaces_active` on `is_active`

**Usage Patterns**:
- Query active workspaces: `SELECT * FROM workspaces WHERE is_active = TRUE`
- Workspace settings lookup: `settings->>'standup_time'`

---

### Users

**Purpose**: Store team member profiles and preferences


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| user_id | VARCHAR(255) | PRIMARY KEY | Internal user ID |
| workspace_id | VARCHAR(255) | FK → workspaces | Parent workspace |
| slack_user_id | VARCHAR(255) | NOT NULL, UNIQUE | Slack's user ID |
| display_name | VARCHAR(255) | | User's display name |
| email | VARCHAR(255) | | Email address |
| timezone | VARCHAR(100) | | User timezone (e.g., "America/New_York") |
| is_active | BOOLEAN | DEFAULT TRUE | Active status |
| joined_at | TIMESTAMP | DEFAULT NOW() | Join date |
| role | VARCHAR(50) | CHECK | Member, Manager, Admin, or Bot |
| last_active | TIMESTAMP | | Last activity timestamp |
| preferences | JSONB | | User preferences (JSON) |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation |
| updated_at | TIMESTAMP | AUTO-UPDATE | Last update |

**Relationships**:
- ← `workspaces` (many-to-one)
- → `standup_responses` (one-to-many)
- → `tasks` (one-to-many as assignee)
- → `messages` (one-to-many as sender)
- → `reminders` (one-to-many)

**Indexes**:
- `idx_users_workspace` on `workspace_id`
- `idx_users_slack_id` on `slack_user_id`
- `idx_users_active` on `is_active`

**Unique Constraints**:
- `(workspace_id, slack_user_id)` - Prevent duplicate users per workspace

**Usage Patterns**:
```sql
-- Find user by Slack ID
SELECT * FROM users WHERE slack_user_id = 'U123456' AND workspace_id = 'W789';

-- Get active team members
SELECT * FROM users WHERE workspace_id = 'W789' AND is_active = TRUE AND role = 'Member';

-- User preferences
SELECT preferences->>'notification_time' FROM users WHERE user_id = 'user_123';
```

---

### Channels

**Purpose**: Track monitored Slack channels and their configurations


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| channel_id | VARCHAR(255) | PRIMARY KEY | Internal channel ID |
| workspace_id | VARCHAR(255) | FK → workspaces | Parent workspace |
| slack_channel_id | VARCHAR(255) | NOT NULL, UNIQUE | Slack's channel ID |
| channel_name | VARCHAR(255) | | Channel name |
| channel_type | VARCHAR(50) | CHECK | Public, Private, or DM |
| is_monitored | BOOLEAN | DEFAULT FALSE | Monitoring status |
| monitoring_config | JSONB | | Monitoring settings (JSON) |
| standup_enabled | BOOLEAN | DEFAULT FALSE | Standup feature toggle |
| summary_enabled | BOOLEAN | DEFAULT FALSE | Summary feature toggle |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation |
| updated_at | TIMESTAMP | AUTO-UPDATE | Last update |

**Relationships**:
- ← `workspaces` (many-to-one)
- → `threads` (one-to-many)
- → `standups` (one-to-many)
- → `summaries` (one-to-many)

**Indexes**:
- `idx_channels_workspace` on `workspace_id`
- `idx_channels_monitored` on `is_monitored`
- `idx_channels_standup` on `standup_enabled`

**Usage Patterns**:
```sql
-- Get monitored channels for a workspace
SELECT * FROM channels WHERE workspace_id = 'W789' AND is_monitored = TRUE;

-- Channels with standup enabled
SELECT * FROM channels WHERE standup_enabled = TRUE;

-- Channel configuration
SELECT monitoring_config->>'response_threshold' FROM channels WHERE channel_id = 'C123';
```

---

## Communication Tracking

### Threads

**Purpose**: Track conversation threads for context and summary generation


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| thread_id | VARCHAR(255) | PRIMARY KEY | Internal thread ID |
| channel_id | VARCHAR(255) | FK → channels | Parent channel |
| slack_thread_ts | VARCHAR(255) | NOT NULL, UNIQUE | Slack thread timestamp |
| started_at | TIMESTAMP | | Thread start time |
| last_activity | TIMESTAMP | | Last message timestamp |
| message_count | INTEGER | DEFAULT 0 | Number of messages |
| participant_count | INTEGER | DEFAULT 0 | Unique participants |
| has_summary | BOOLEAN | DEFAULT FALSE | Summary generated flag |
| status | VARCHAR(50) | CHECK | Active, Idle, Resolved, or Archived |
| has_decision | BOOLEAN | DEFAULT FALSE | Contains decisions |
| has_tasks | BOOLEAN | DEFAULT FALSE | Contains action items |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation |
| updated_at | TIMESTAMP | AUTO-UPDATE | Last update |

**Relationships**:
- ← `channels` (many-to-one)
- → `messages` (one-to-many)
- → `tasks` (one-to-many)
- → `decisions` (one-to-many)
- → `summaries` (one-to-many)

**Indexes**:
- `idx_threads_channel` on `channel_id`
- `idx_threads_status` on `status`
- `idx_threads_last_activity` on `last_activity`

**Usage Patterns**:
```sql
-- Active threads with tasks
SELECT * FROM threads 
WHERE status = 'Active' AND has_tasks = TRUE 
ORDER BY last_activity DESC;

-- Threads needing summaries
SELECT * FROM threads 
WHERE message_count > 20 AND has_summary = FALSE;

-- Stale threads
SELECT * FROM threads 
WHERE status = 'Active' 
  AND last_activity < NOW() - INTERVAL '7 days';
```

---

### Messages

**Purpose**: Store individual messages with embeddings for semantic search


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| message_id | VARCHAR(255) | PRIMARY KEY | Internal message ID |
| thread_id | VARCHAR(255) | FK → threads | Parent thread |
| user_id | VARCHAR(255) | FK → users | Message sender |
| slack_message_ts | VARCHAR(255) | NOT NULL, UNIQUE | Slack message timestamp |
| message_text | TEXT | | Message content |
| sent_at | TIMESTAMP | | Send timestamp |
| message_type | VARCHAR(50) | CHECK | User/Bot/System/Agent Message |
| has_mentions | BOOLEAN | DEFAULT FALSE | Contains @mentions |
| has_attachments | BOOLEAN | DEFAULT FALSE | Has files/images |
| embedding_vector | VECTOR(1536) | | Semantic embedding |
| context_summary | TEXT | | AI-generated context |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation |

**Relationships**:
- ← `threads` (many-to-one)
- ← `users` (many-to-one)

**Indexes**:
- `idx_messages_thread` on `thread_id`
- `idx_messages_user` on `user_id`
- `idx_messages_sent_at` on `sent_at`
- `idx_messages_embedding` using IVFFlat for vector similarity

**Vector Search Example**:
```sql
-- Find similar messages (requires pgvector)
SELECT message_id, message_text, 
       1 - (embedding_vector <=> query_vector) AS similarity
FROM messages
ORDER BY embedding_vector <=> query_vector
LIMIT 10;
```

---

## Async Coordination

### Standups

**Purpose**: Manage daily async standup instances


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| standup_id | VARCHAR(255) | PRIMARY KEY | Internal standup ID |
| channel_id | VARCHAR(255) | FK → channels | Target channel |
| standup_date | DATE | NOT NULL, UNIQUE | Standup date |
| status | VARCHAR(50) | CHECK | Scheduled/In Progress/Completed/Cancelled |
| triggered_at | TIMESTAMP | | Trigger time |
| completed_at | TIMESTAMP | | Completion time |
| response_count | INTEGER | DEFAULT 0 | Number of responses |
| summary | TEXT | | Generated summary |
| questions | JSONB | | Custom questions (JSON array) |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation |
| updated_at | TIMESTAMP | AUTO-UPDATE | Last update |

**Relationships**:
- ← `channels` (many-to-one)
- → `standup_responses` (one-to-many)

**Indexes**:
- `idx_standups_channel` on `channel_id`
- `idx_standups_date` on `standup_date`
- `idx_standups_status` on `status`

**Usage Patterns**:
```sql
-- Today's standups
SELECT * FROM standups WHERE standup_date = CURRENT_DATE;

-- Calculate participation rate
SELECT 
  channel_id,
  AVG(response_count::float / expected_participants) as participation_rate
FROM standups
WHERE standup_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY channel_id;
```

---

### Standup Responses

**Purpose**: Store individual user responses to standups


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| response_id | VARCHAR(255) | PRIMARY KEY | Internal response ID |
| standup_id | VARCHAR(255) | FK → standups | Parent standup |
| user_id | VARCHAR(255) | FK → users | Responding user |
| submitted_at | TIMESTAMP | | Submission time |
| response_text | TEXT | | Full response text |
| status | VARCHAR(50) | CHECK | Pending/Submitted/Skipped/Late |
| what_worked_on | TEXT | | Yesterday's work |
| whats_next | TEXT | | Today's plan |
| blockers | TEXT | | Blockers/issues |
| has_blockers | BOOLEAN | DEFAULT FALSE | Has blockers flag |
| follow_up_needed | BOOLEAN | DEFAULT FALSE | Needs follow-up |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation |
| updated_at | TIMESTAMP | AUTO-UPDATE | Last update |

**Unique Constraints**:
- `(standup_id, user_id)` - One response per user per standup

**Usage Patterns**:
```sql
-- Responses with blockers
SELECT * FROM standup_responses WHERE has_blockers = TRUE;

-- User's response history
SELECT * FROM standup_responses 
WHERE user_id = 'U123' 
ORDER BY submitted_at DESC 
LIMIT 30;
```

---

## Task & Decision Management

### Tasks

**Purpose**: Track action items identified from conversations


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| task_id | VARCHAR(255) | PRIMARY KEY | Internal task ID |
| thread_id | VARCHAR(255) | FK → threads | Source thread |
| assigned_to | VARCHAR(255) | FK → users | Task assignee |
| created_by | VARCHAR(255) | FK → users | Task creator |
| task_description | TEXT | NOT NULL | Task details |
| status | VARCHAR(50) | CHECK | Open/In Progress/Blocked/Completed/Cancelled |
| priority | VARCHAR(50) | CHECK | Low/Medium/High/Urgent |
| due_date | DATE | | Due date |
| completed_at | TIMESTAMP | | Completion timestamp |
| is_blocked | BOOLEAN | DEFAULT FALSE | Blocked status |
| last_reminder | TIMESTAMP | | Last reminder sent |
| reminder_count | INTEGER | DEFAULT 0 | Number of reminders |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation |
| updated_at | TIMESTAMP | AUTO-UPDATE | Last update |

**Indexes**:
- `idx_tasks_assigned` on `assigned_to`
- `idx_tasks_status` on `status`
- `idx_tasks_priority` on `priority`
- `idx_tasks_due_date` on `due_date`

**Usage Patterns**:
```sql
-- Overdue tasks
SELECT * FROM tasks 
WHERE status NOT IN ('Completed', 'Cancelled') 
  AND due_date < CURRENT_DATE;

-- User's open tasks
SELECT * FROM tasks 
WHERE assigned_to = 'U123' 
  AND status IN ('Open', 'In Progress')
ORDER BY priority DESC, due_date ASC;
```

---

### Decisions

**Purpose**: Capture and track key decisions from discussions


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| decision_id | VARCHAR(255) | PRIMARY KEY | Internal decision ID |
| thread_id | VARCHAR(255) | FK → threads | Source thread |
| decision_text | TEXT | NOT NULL | Decision details |
| made_at | TIMESTAMP | | Decision timestamp |
| decision_type | VARCHAR(50) | CHECK | Technical/Product/Process/Resource/Strategic |
| context | TEXT | | Decision context |
| impact | VARCHAR(50) | CHECK | Low/Medium/High/Critical |
| stakeholders | TEXT | | Involved parties |
| is_implemented | BOOLEAN | DEFAULT FALSE | Implementation status |
| related_tasks | JSONB | | Related task IDs |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation |
| updated_at | TIMESTAMP | AUTO-UPDATE | Last update |

**Indexes**:
- `idx_decisions_thread` on `thread_id`
- `idx_decisions_type` on `decision_type`
- `idx_decisions_impact` on `impact`

**Usage Patterns**:
```sql
-- High-impact unimplemented decisions
SELECT * FROM decisions 
WHERE impact IN ('High', 'Critical') 
  AND is_implemented = FALSE;

-- Recent technical decisions
SELECT * FROM decisions 
WHERE decision_type = 'Technical' 
  AND made_at >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY made_at DESC;
```

---

## Agent Operations

### Summaries

**Purpose**: Store generated summaries of discussions


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| summary_id | VARCHAR(255) | PRIMARY KEY | Internal summary ID |
| thread_id | VARCHAR(255) | FK → threads | Source thread |
| channel_id | VARCHAR(255) | FK → channels | Source channel |
| summary_text | TEXT | NOT NULL | Full summary |
| summary_type | VARCHAR(50) | CHECK | Thread/Channel/Daily/Weekly Summary |
| key_points | TEXT | | Extracted key points |
| action_items | TEXT | | Action items found |
| decisions_made | TEXT | | Decisions identified |
| open_questions | TEXT | | Unanswered questions |
| posted_to_slack | BOOLEAN | DEFAULT FALSE | Posted flag |
| created_at | TIMESTAMP | DEFAULT NOW() | Generation time |

**Indexes**:
- `idx_summaries_thread` on `thread_id`
- `idx_summaries_type` on `summary_type`
- `idx_summaries_created` on `created_at`

---

### Reminders

**Purpose**: Manage scheduled reminders and nudges


| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| reminder_id | VARCHAR(255) | PRIMARY KEY | Internal reminder ID |
| user_id | VARCHAR(255) | FK → users | Target user |
| task_id | VARCHAR(255) | FK → tasks | Related task |
| thread_id | VARCHAR(255) | FK → threads | Source thread |
| reminder_type | VARCHAR(50) | CHECK | Standup/Task/Question/Escalation/General |
| reminder_text | TEXT | | Reminder message |
| scheduled_for | TIMESTAMP | NOT NULL | Scheduled time |
| sent_at | TIMESTAMP | | Actual send time |
| status | VARCHAR(50) | CHECK | Pending/Sent/Acknowledged/Dismissed/Failed |
| attempts | INTEGER | DEFAULT 0 | Send attempts |
| escalation_level | VARCHAR(50) | CHECK | Normal/Warning/Urgent |
| created_at | TIMESTAMP | DEFAULT NOW() | Record creation |
| updated_at | TIMESTAMP | AUTO-UPDATE | Last update |

**Indexes**:
- `idx_reminders_user` on `user_id`
- `idx_reminders_scheduled` on `scheduled_for`
- `idx_reminders_status` on `status`

**Usage Patterns**:
```sql
-- Pending reminders to send
SELECT * FROM reminders 
WHERE status = 'Pending' 
  AND scheduled_for <= NOW();

-- Failed reminders needing retry
SELECT * FROM reminders 
WHERE status = 'Failed' 
  AND attempts < 3;
```

---


**Schema Version**: 1.0.0  
**Last Updated**: 2026-01-26
