# Overview
Agentic system workflow patterns describe **how multiple AI agents (or one agent with tools and memory) are organized to reason, act, and collaborate** to solve tasks. 

---

## 1. Single-Agent (ReAct Pattern)

**Think → Act → Observe → Repeat**

**Workflow**

1. Receive task
    
2. Reason about next step
    
3. Use a tool (search, DB, API)
    
4. Observe result
    
5. Continue until done
    

**Used in**

- Simple assistants
    
- Tool-using chatbots
    
- RAG with one agent
    

**Example**

```
User → LLM → Search Tool → LLM → Answer
```

**Code**

```python
def llm_node(state):
    return state

def tool_node(state):
    return state

graph.add_node("llm", llm_node)
graph.add_node("tool", tool_node)

graph.add_conditional_edges(
    "llm",
    should_use_tool,
    {True: "tool", False: END}
)
graph.add_edge("tool", "llm")

```

**Pros**

- Simple
    
- Easy to debug
    

**Cons**

- Limited scalability
    
- No specialization
    

---

## 2. Router / Classifier Pattern

**Decide which path or agent should handle the task**

**Workflow**

1. Classifier agent analyzes query
    
2. Routes to correct agent or workflow
    

**Used in**

- RAG systems
    
- Multi-domain assistants
    

**Example**

```
User Query
   ↓
Classifier
 ├─ SQL Agent
 ├─ RAG Agent
 └─ General Chat Agent
```

**Your RAG system already uses this pattern.**

---

## 3. Planner–Executor Pattern

**Plan first, then execute steps**

**Workflow**

1. Planner agent creates a task plan
    
2. Executor agent runs steps sequentially
    

**Example**

```
Planner:
1. Search docs
2. Extract facts
3. Summarize

Executor:
→ Step 1 → Step 2 → Step 3
```

**Used in**

- Complex reasoning
    
- Long tasks
    
- Automation
    

**Key idea**

> Separate _thinking_ from _doing_

---

## 4. Tool-Driven Agent Pattern

**LLM chooses tools dynamically**

**Workflow**

1. LLM decides if tool is needed
    
2. Calls tool
    
3. Reads tool result
    
4. Continues reasoning
    

**Used in**

- RAG
    
- Code agents
    
- Data analysis agents
    

**Example tools**

- Vector DB
    
- SQL
    
- Web search
    
- File system
    

---

## 5. Multi-Agent Collaboration Pattern

**Multiple specialized agents cooperate**

**Workflow**

1. Coordinator agent assigns roles
    
2. Agents work independently
    
3. Results are merged
    

**Example**

```
Coordinator
 ├─ Research Agent
 ├─ Analysis Agent
 ├─ Writer Agent
```

**Used in**

- Research systems
    
- Report generation
    
- Product design
    

---

## 6. Debate / Critic Pattern

**Agents challenge each other to improve quality**

**Workflow**

1. Agent A produces answer
    
2. Agent B critiques
    
3. Agent A revises
    

**Used in**

- High-accuracy systems
    
- Safety-critical tasks
    

**Example**

```
Answer → Critic → Revised Answer
```

---

## 7. Reflection / Self-Improvement Pattern

**Agent evaluates its own output**

**Workflow**

1. Produce answer
    
2. Reflect on quality
    
3. Improve if needed
    

**Used in**

- Reasoning-heavy tasks
    
- Code generation
    

---

## 8. Memory-Augmented Agent

**Agent uses long-term and short-term memory**

### Memory types

- **Short-term**: conversation state
    
- **Long-term**: vector store, DB
    
- **Episodic**: past experiences
    

**Workflow**

```
Input
 ↓
Retrieve Memory
 ↓
Reason
 ↓
Act
 ↓
Store Memory
```

**Used in**

- Personal assistants
    
- Long-running agents
    

---

## 9. Event-Driven Agent (Reactive Systems)

**Agents respond to events, not prompts**

**Workflow**

```
Event → Agent → Action
```

**Used in**

- Monitoring systems
    
- Autonomous workflows
    
- DevOps bots
    

---

## 10. Human-in-the-Loop Pattern

**Human approval or feedback included**

**Workflow**

1. Agent proposes action
    
2. Human approves/rejects
    
3. Agent proceeds
    

**Used in**

- Medical
    
- Finance
    
- Legal systems
    

---

## 11. DAG / Graph-Based Agent Workflow (LangGraph Style)

**Explicit state machine**

**Workflow**

- Nodes = actions
    
- Edges = transitions
    
- Conditional routing
    

**Example**

```
Classify → Retrieve → Reason → Answer → End
```

**Used in**

- Production agent systems
    
- Debuggable pipelines
    

---

## 12. Hybrid RAG Agent (Most Common in Practice)

**Best real-world pattern**

**Combines**

- Router
    
- Tools
    
- Memory
    
- Planner
    

**Workflow**

```
User
 ↓
Classifier
 ├─ Vector Search
 ├─ SQL
 └─ LLM
 ↓
Answer
```

---

## Pattern Selection Cheat Sheet

|Goal|Best Pattern|
|---|---|
|Simple assistant|ReAct|
|RAG system|Router + Tool Agent|
|Complex tasks|Planner–Executor|
|High accuracy|Debate + Reflection|
|Long-term assistant|Memory Agent|
|Production system|Graph-based|

---

## Final Mental Model

> **Agentic systems = Reasoning + Tools + Memory + Control Flow**

If you want, I can:

- Map these patterns to **LangGraph**
    
- Show **code templates**
    
- Design an **enterprise-grade agent architecture**
    
- Explain **Agent-to-Agent (A2A)** workflows in detail