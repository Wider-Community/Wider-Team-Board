# What “LLM Resources” Actually Mean

LLM cost ≠ just model size.

You must account for:

|Resource|What it affects|
|---|---|
|**Parameters**|VRAM / RAM|
|**Context window**|KV cache memory|
|**Batch size**|Throughput|
|**Tokens/sec**|Latency|
|**Precision**|Memory & speed|
|**Concurrency**|Scaling cost|

---

# Model Size → Memory (VRAM / RAM)

### Rule of Thumb

```
Memory (GB) ≈ Parameters × bytes_per_param
```

### Precision Reference

|Precision|Bytes/param|
|---|---|
|FP32|4|
|FP16 / BF16|2|
|INT8|1|
|INT4|0.5|

### Example

**7B model (FP16)**:

```
7B × 2 bytes = 14 GB VRAM
```

**13B INT4**:

```
13B × 0.5 = 6.5 GB
```

---

# KV Cache

KV cache grows with **context length**.

### Formula (approx)

```
KV Cache ≈ 
2 × num_layers × hidden_size × context_length × bytes
```

### Example (LLaMA-like)

- Layers: 32
    
- Hidden size: 4096
    
- Context: 8k
    
- FP16
    

➡️ ~6–8 GB extra VRAM

📌 **Long context = expensive memory**

---

# Total GPU Memory Estimation

```
Total VRAM =
Model weights
+ KV cache
+ Activation overhead (~10–20%)
```

### Example

|Item|GB|
|---|---|
|Model (7B FP16)|14|
|KV cache (8k ctx)|6|
|Overhead|2|
|**Total**|**22 GB**|

➡️ Needs **RTX 3090 / A5000+**

---

# CPU / RAM Requirements (Local)

|Model|RAM Needed|
|---|---|
|7B INT4|8–10 GB|
|13B INT4|16–20 GB|
|70B INT4|64+ GB|

CPU inference is:

- ❌ Slower
    
- ✔ Cheaper
    
- ✔ OK for RAG / agents
    

---

# Throughput & Latency

### Tokens per second depends on:

- GPU type
    
- Model size
    
- Context length
    

### Rough numbers (FP16, single request)

|Model|GPU|Tokens/sec|
|---|---|---|
|7B|RTX 3090|40–60|
|13B|RTX 3090|20–30|
|70B|A100|15–25|

---

# API Pricing (Cloud Models)

### General pricing model

```
Cost = (input_tokens × price_in)
     + (output_tokens × price_out)
```

### Example Prices (approx)

|Model|Input / 1M|Output / 1M|
|---|---|---|
|GPT-4-Turbo|$10|$30|
|GPT-3.5|$0.5|$1.5|
|Claude 3 Opus|$15|$75|
|OpenRouter (varies)|$0.2–$10|$0.5–$30|

---

# Estimating API Cost (Example)

### Scenario

- Avg prompt: 2,000 tokens
    
- Avg output: 500 tokens
    
- Requests/day: 1,000
    

### GPT-4 Turbo

```
Input cost:
2,000 × 1,000 / 1M × $10 = $20

Output cost:
500 × 1,000 / 1M × $30 = $15

Daily total ≈ $35
Monthly ≈ $1,050
```

---

# RAG Cost Breakdown

RAG increases **input tokens**, not output.

### Typical RAG Prompt

|Component|Tokens|
|---|---|
|System prompt|200|
|User query|50|
|Retrieved context|1,500|
|Instructions|150|
|**Total input**|~1,900|

📌 **Embedding cost is separate**

---

# Embedding Cost Estimation

### Embedding pricing (example)

|Model|Cost / 1M tokens|
|---|---|
|OpenAI text-embedding-3|~$0.02|
|Local (Ollama)|$0 (hardware only)|

### Example

- 50 CVs × 1,000 tokens each
    

```
50k tokens → $0.001
```

Embedding is **cheap**.

---

# Local vs Cloud Cost Comparison

### Local GPU (RTX 4090)

|Item|Cost|
|---|---|
|GPU|$1,600|
|Power (monthly)|~$30|
|Cooling / infra|~$20|

Break-even vs API:

```
~2–3 months for heavy usage
```

---

# Estimating for Agents (LangGraph / CrewAI)

Agents multiply calls ⚠️

### Example

|Step|Calls|
|---|---|
|Classifier|1|
|Retriever|1|
|Planner|1|
|Tool use|2|
|Final answer|1|
|**Total**|**6 calls**|

Multiply your cost × **agent steps**

---

# Concurrency Planning

### Formula

```
Required GPUs ≈
(QPS × avg_latency) / GPU_throughput
```

### Example

- 5 QPS
    
- 2 sec per response
    
- GPU handles 2 req/sec
    

➡️ `(5×2)/2 = 5 GPUs`

---

# Cost Optimization Checklist

✔ Reduce context  
✔ Chunk documents smarter  
✔ Cache embeddings  
✔ Use smaller model for routing  
✔ Quantize locally (Q4/Q8)  
✔ Stream outputs  
✔ Batch requests

---

# Decision Guide

|Use Case|Best Option|
|---|---|
|MVP|Cloud API|
|RAG small scale|Local 7B|
|Agents heavy|Local GPU|
|Sensitive data|Local only|
|High QPS|GPU cluster|
|Cost sensitive|INT4 + RAG|


