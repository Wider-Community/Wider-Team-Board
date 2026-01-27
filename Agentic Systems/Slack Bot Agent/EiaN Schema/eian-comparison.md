# EiaN vs Traditional Schema Comparison

```mermaid
flowchart LR
    subgraph TRADITIONAL["Traditional Schema (12 Tables)"]
        direction TB
        T1[workspaces]
        T2[users]
        T3[channels]
        T4[threads]
        T5[messages]
        T6[standups]
        T7[standup_responses]
        T8[tasks]
        T9[decisions]
        T10[summaries]
        T11[reminders]
        T12[...]

        T1 --> T2
        T1 --> T3
        T3 --> T4
        T4 --> T5
        T2 --> T5
        T3 --> T6
        T6 --> T7
        T4 --> T8
        T4 --> T9
        T4 --> T10
        T2 --> T11
    end

    subgraph EIAN["EiaN Schema (4 Core Tables)"]
        direction TB
        E1[(spaces)]
        E2[(nodes)]
        E3[(contexts)]
        E4[(embeddings)]

        E1 -->|"contains"| E2
        E2 -->|"has"| E4
        E3 -->|"connects"| E2
        E3 -->|"tracks"| E1
    end

    TRADITIONAL -.->|"transforms to"| EIAN

    subgraph BENEFITS["EiaN Benefits"]
        direction TB
        B1["Flexible Schema
        Add new types without
        schema changes"]
        B2["Graph Queries
        Traverse relationships
        easily"]
        B3["Temporal Tracking
        Built-in state history"]
        B4["Semantic Search
        Native vector support"]
    end

    EIAN --> BENEFITS

    %% Styling
    classDef traditional fill:#666,color:#fff
    classDef eian fill:#2EB67D,color:#fff
    classDef benefit fill:#1264A3,color:#fff

    class T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12 traditional
    class E1,E2,E3,E4 eian
    class B1,B2,B3,B4 benefit
```

## Schema Mapping

| Traditional Table | EiaN Equivalent |
|-------------------|-----------------|
| workspaces | `spaces` where `space_type = 'workspace'` |
| channels | `spaces` where `space_type = 'channel'` |
| threads | `spaces` where `space_type = 'thread'` |
| users | `nodes` where `node_type = 'agent'` |
| messages | `nodes` where `node_type = 'message'` |
| tasks | `nodes` where `node_type = 'task'` |
| decisions | `nodes` where `node_type = 'decision'` |
| summaries | `nodes` where `node_type = 'summary'` |
| standups/reminders | `nodes` where `node_type = 'event'` |
| FK relationships | `contexts` where `context_type = 'connection'` |
| status changes | `contexts` where `context_type = 'state'` |
| tags/labels | `contexts` where `context_type = 'annotation'` |
