# Overview
An **output parser** is the component that turns an LLM’s **raw text output** into a **reliable, structured format** (JSON, list, object, SQL, etc.) that your program can safely use.

----
# Why Output Parsers Matter

LLMs:

- Are **probabilistic**
    
- May add explanations, markdown, or extra text
    
- Can break your pipeline if output shape changes
    

Output parsers give you:  
✅ Deterministic structure  
✅ Type safety  
✅ Validation  
✅ Error recovery

---

# Simplest Output Parser (Manual)

### Problem

LLM returns:

```
Answer: Yes
Confidence: 0.87
```

### Manual parsing

```python
text = llm_output
answer = "Yes" in text
```

❌ Fragile  
❌ Not scalable

---

# LangChain Built-in Output Parsers

## 3.1 `StrOutputParser`

Use when you only want clean text.

```python
from langchain_core.output_parsers import StrOutputParser

parser = StrOutputParser()
result = parser.invoke(llm_output)
```

✔ Removes wrappers  
✔ Minimal

---

## 3.2 `CommaSeparatedListOutputParser`

```python
from langchain.output_parsers import CommaSeparatedListOutputParser

parser = CommaSeparatedListOutputParser()
```

LLM output:

```
Python, SQL, FastAPI
```

Parsed:

```python
["Python", "SQL", "FastAPI"]
```

---

# Structured Output with Pydantic (Best Practice)

### Step 1: Define schema

```python
from pydantic import BaseModel, Field

class Classification(BaseModel):
    query_type: str = Field(description="document, sql, or general")
    confidence: float
```

---

### Step 2: Create parser

```python
from langchain.output_parsers import PydanticOutputParser

parser = PydanticOutputParser(pydantic_object=Classification)
```

---

### Step 3: Inject format instructions

```python
prompt = f"""
Classify the query.
{parser.get_format_instructions()}
Query: {question}
"""
```

---

### Step 4: Parse output

```python
result = parser.parse(llm_output)
print(result.query_type)
```

✔ Validated  
✔ Typed  
✔ Production-ready

---

# JSON Output Parser

Use when integrating with APIs / frontend.

```python
from langchain.output_parsers import JsonOutputParser

parser = JsonOutputParser()
```

LLM output:

```json
{"answer": "Yes", "confidence": 0.9}
```

Parsed → `dict`

---

# Fixing Broken Output (Retry + Repair)

LLMs **will fail sometimes**.

### Auto-fix parser

```python
from langchain.output_parsers import OutputFixingParser

fixing_parser = OutputFixingParser.from_llm(
    llm=llm,
    parser=parser
)
```

Now:

- Detects invalid output
    
- Calls LLM again
    
- Repairs format
    

✔ Huge reliability boost

---

# Output Parsers in Chains

### Example

```python
chain = prompt | llm | parser
result = chain.invoke({"question": q})
```

This is the **recommended pattern**.

---

# Output Parsers in LangGraph

### Pattern

Each node returns **structured state**

### Example

```python
class GraphState(TypedDict):
    query_type: str
    confidence: float

def classify_node(state):
    result = chain.invoke(state["question"])
    state["query_type"] = result.query_type
    state["confidence"] = result.confidence
    return state
```

✔ Clean state  
✔ Debuggable  
✔ Safe routing

---

# Output Parsing for SQL Generation

### SQL-only output

```python
class SQLQuery(BaseModel):
    sql: str
```

Prompt:

```
Return ONLY valid SQL.
{format_instructions}
```

Parser prevents:

- Markdown
    
- Explanation
    
- Hallucinations
    

---

# Tool Output vs Output Parser

|Feature|Tool|Output Parser|
|---|---|---|
|Purpose|Execute code|Structure text|
|Determinism|High|Medium|
|Validation|Runtime|Schema-based|
|Best for|Actions|Decisions|

**They complement each other**.

---

# Common Mistakes

❌ Not injecting format instructions  
❌ Parsing free-form text  
❌ Using regex instead of schema  
❌ Trusting LLM output blindly

---

# Recommended Stack (Production)

```text
Prompt
  ↓
LLM
  ↓
PydanticOutputParser
  ↓
OutputFixingParser
  ↓
LangGraph State
```

---

# Mental Model (Important)

> **Prompt tells the LLM _what to say_**  
> **Output parser tells your system _what to trust_**

---

# When to Use Which Parser

|Use Case|Parser|
|---|---|
|Plain answer|StrOutputParser|
|Lists|CommaSeparatedList|
|Routing|Pydantic|
|SQL|Pydantic / JSON|
|APIs|JSON|
|Agents|Pydantic + Fixing|

