# Wider Machine Architecture

## The Five Machines + Supercomputer Infrastructure

The Wider ecosystem's technical and operational backbone consists of a 200-GPU supercomputer infrastructure supporting five specialized internal machines. Each machine operates as an independent capability unit and cost center, delivering distinct services while sharing infrastructure, data, and intelligence.

---

## Machine Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    WIDER MACHINE ARCHITECTURE                                │
│                  (5 Machines + Supercomputer Model)                          │
└─────────────────────────────────────────────────────────────────────────────┘

                         MACHINE LAYER (Service Delivery)

    ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
    │          │  │Recommend.│  │  People  │  │ Content  │  │  Coding  │
    │ Mujarrad │  │  Engine  │  │ Machine  │  │ Machine  │  │ Machine  │
    │  (Data)  │  │ (Routing)│  │(Talent)  │  │(Creation)│  │(Dev)     │
    └─────┬────┘  └─────┬────┘  └─────┬────┘  └─────┬────┘  └─────┬────┘
          │             │             │             │             │
          │             │             │             │             │
    ──────┴─────────────┴─────────────┴─────────────┴─────────────┴──────
          ▲             ▲             ▲             ▲             ▲
          │             │             │             │             │
          │      SHARED INTELLIGENCE & DATA FLOWS                 │
          │             │             │             │             │
    ──────┴─────────────┴─────────────┴─────────────┴─────────────┴──────
          │             │             │             │             │
          │             │             │             │             │
          └─────────────┴─────────────┴─────────────┴─────────────┘
                                      │
                                      ▼
              ╔═════════════════════════════════════════════╗
              ║                                             ║
              ║      200-GPU SUPERCOMPUTER                  ║
              ║      INFRASTRUCTURE                         ║
              ║                                             ║
              ║  • AI Training & Inference                  ║
              ║  • Internal R&D                             ║
              ║  • Community Experimentation                ║
              ║  • External Compute-as-a-Service            ║
              ║                                             ║
              ╚═════════════════════════════════════════════╝
```

---

## Supercomputer Infrastructure (Foundation Layer)

### Technical Specifications
- **Capacity**: 200-GPU cluster
- **Primary Use**: AI training, large-scale inference, automation
- **Shared Infrastructure**: All machines draw compute as needed

### Dual Purpose Model

```
┌─────────────────────────────────────────────────────────────────┐
│             SUPERCOMPUTER CAPACITY ALLOCATION                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  INTERNAL USE (Subsidized Rates)                                │
│  ████████████████░░░░░░░░░░  60-70%                            │
│  • AI model training for machines                               │
│  • Internal automation and tools                                │
│  • Community experimentation                                    │
│  • R&D and prototyping                                          │
│                                                                 │
│  EXTERNAL MONETIZATION (Market Rates)                           │
│  ░░░░░░░░░░████████████████  30-40%                            │
│  • Compute-as-a-Service sales                                   │
│  • Model training for external clients                          │
│  • Inference API services                                       │
│  • Data processing jobs                                         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Revenue Model
- **Internal**: Machines pay blended internal rates (Cost + 5-10%)
- **External**: Sold at market rates (Cost + 30-50%)
- **Strategic Benefit**: Makes high-performance compute accessible to internal projects while generating external revenue

### Future Transition Plan
Initial internal GPU infrastructure → Strategic partnerships with Cloud Service Providers (CSPs)
- **Local CSPs**: Ghaymah, HUMAIN (regional focus)
- **Model**: Wider provides AI software/models, CSPs provide hardware
- **Cost Efficiency**: Long-term partnerships ensure better pricing for startups

---

## The Five Specialized Machines

### Machine 1: Mujarrad (Data Technology Machine)

**Core Function**: Data foundation for entire ecosystem

```
┌─────────────────────────────────────────────────────────────────┐
│                         MUJARRAD                                 │
│                  (Data Technology Machine)                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PRIMARY RESPONSIBILITIES:                                      │
│  • Data collection from multiple sources                        │
│  • Data cleaning and standardization                            │
│  • Data structuring and schema management                       │
│  • Privacy-compliant ingestion and storage                      │
│  • Data governance and access control                           │
│                                                                 │
│  VALUE UNITS PRODUCED:                                          │
│  • Clean datasets                                               │
│  • Data pipelines                                               │
│  • Data products (subscriptions)                                │
│                                                                 │
│  COST DRIVERS:                                                  │
│  • Data engineer hours                                          │
│  • Storage (TB-months)                                          │
│  • Processing compute                                           │
│  • Data source licensing                                        │
│                                                                 │
│  REVENUE MECHANISMS:                                            │
│  • Data integration services to partners                        │
│  • Subscription-based data products                             │
│  • Internal charges to other machines (transfer pricing)        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Team**: Data engineers, AI specialists
**Internal Customers**: All other machines (foundational dependency)
**External Customers**: Partners needing data integration

---

### Machine 2: Recommendation Engine

**Core Function**: Intelligent matching and routing across ecosystem

```
┌─────────────────────────────────────────────────────────────────┐
│                   RECOMMENDATION ENGINE                          │
│                   (Intelligent Routing Machine)                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PRIMARY RESPONSIBILITIES:                                      │
│  • Match members to tasks and projects                          │
│  • Connect teams to opportunities                               │
│  • Route digital assets to high-value uses                      │
│  • Suggest partnerships based on complementary needs            │
│  • Optimize resource allocation                                 │
│                                                                 │
│  VALUE UNITS PRODUCED:                                          │
│  • Successful matches (member-project fit)                      │
│  • Routing recommendations                                      │
│  • Conversion lift (opportunity → project)                      │
│                                                                 │
│  COST DRIVERS:                                                  │
│  • AI/ML engineer hours                                         │
│  • Model training compute (GPU-hours)                           │
│  • Inference API calls                                          │
│  • Algorithm optimization                                       │
│                                                                 │
│  REVENUE MECHANISMS:                                            │
│  • Premium matching services                                    │
│  • Prioritized routing (members pay for visibility)             │
│  • Enterprise recommendations (advanced features)               │
│  • Internal charges for routing services                        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Model Basis**: Trained on supercomputer using ecosystem data
**Internal Customers**: Wider Hub, Network, Marketplace
**External Customers**: Enterprise clients needing advanced matching

---

### Machine 3: People Machine

**Core Function**: Talent automation and team formation

```
┌─────────────────────────────────────────────────────────────────┐
│                       PEOPLE MACHINE                             │
│                  (Talent Automation Machine)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PRIMARY RESPONSIBILITIES:                                      │
│  • Automate recruitment and screening                           │
│  • Parse profiles and CVs                                       │
│  • Match skills to requirements                                 │
│  • Conduct AI-assisted interviews and assessments               │
│  • Coordinate team formation                                    │
│                                                                 │
│  VALUE UNITS PRODUCED:                                          │
│  • Qualified candidate placements                               │
│  • Team formations (skill-balanced groups)                      │
│  • Recruitment projects completed                               │
│                                                                 │
│  COST DRIVERS:                                                  │
│  • Recruitment specialist hours                                 │
│  • AI screening compute                                         │
│  • Assessment tool licensing                                    │
│  • Interview automation development                             │
│                                                                 │
│  REVENUE MECHANISMS:                                            │
│  • Placement fees (per successful hire)                         │
│  • Recruitment project contracts                                │
│  • Outsourcing engagement fees                                  │
│  • Subscription for recruitment automation access              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Efficiency Gain**: Reduces hiring time and cost by 60-80%
**Internal Customers**: Wider Network (team formation), Core Team (hiring)
**External Customers**: Companies needing recruitment services

---

### Machine 4: Content Machine

**Core Function**: Scaled content production and standardization

```
┌─────────────────────────────────────────────────────────────────┐
│                       CONTENT MACHINE                            │
│                  (Scaled Production Machine)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PRIMARY RESPONSIBILITIES:                                      │
│  • Structured marketing content production                      │
│  • Product documentation creation                               │
│  • Training material development                                │
│  • Standardized workflow and tooling                            │
│  • Brand consistency enforcement                                │
│                                                                 │
│  VALUE UNITS PRODUCED:                                          │
│  • Approved content assets                                      │
│  • Documentation packages                                       │
│  • Marketing collateral                                         │
│  • Training modules                                             │
│                                                                 │
│  COST DRIVERS:                                                  │
│  • Content creator hours                                        │
│  • Design tool licensing                                        │
│  • AI writing assistance compute                                │
│  • Quality review time                                          │
│                                                                 │
│  REVENUE MECHANISMS:                                            │
│  • Content project contracts                                    │
│  • Documentation packages                                       │
│  • Branding and marketing services                              │
│  • Training content licensing                                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Efficiency Gain**: Increases content production 3-5x while reducing cost and time
**Internal Customers**: Wider Community, Hub, Labs (content needs)
**External Customers**: Companies needing content at scale

---

### Machine 5: Coding Machine

**Core Function**: Digital product development and automation

```
┌─────────────────────────────────────────────────────────────────┐
│                        CODING MACHINE                            │
│                   (Digital Delivery Machine)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PRIMARY RESPONSIBILITIES:                                      │
│  • Design and deliver digital products                          │
│  • Build ERP systems and automation solutions                   │
│  • Validation-first development (small experiments first)       │
│  • Proof-of-concept before full-scale development               │
│  • Long-term maintenance and support                            │
│                                                                 │
│  VALUE UNITS PRODUCED:                                          │
│  • Deployable software modules                                  │
│  • Completed digital products                                   │
│  • Automation systems                                           │
│  • Maintained production code                                   │
│                                                                 │
│  COST DRIVERS:                                                  │
│  • Developer hours (story points)                               │
│  • GPU compute (for AI features)                                │
│  • Infrastructure and deployment costs                          │
│  • QA and testing time                                          │
│                                                                 │
│  REVENUE MECHANISMS:                                            │
│  • Milestone-based project revenue                              │
│  • Retainer agreements for maintenance                          │
│  • Licensing of developed software                              │
│  • Support and SLA contracts                                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Strategic Approach**: Validation-first reduces risk and shares cost with clients
**Internal Customers**: Other machines (internal tooling), Wider Labs (product development)
**External Customers**: Clients needing software development

---

## Machine-as-Cost-Center Model

### Activity-Based Costing (ABC) Framework

```
┌─────────────────────────────────────────────────────────────────┐
│             MACHINE COST STRUCTURE (Generic)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  DIRECT COSTS (Fully Attributable)                              │
│  • Human costs (salaries, stipends, mentor time)                │
│  • Compute (GPU hours, cloud compute, storage)                  │
│  • Software (licenses, data sources, tools)                     │
│  • Operations (QA, monitoring, deployment)                      │
│                                                                 │
│  ALLOCATED SHARED COSTS                                         │
│  • Supercomputer infrastructure (by GPU-hours)                  │
│  • Core platform infrastructure (by API calls)                  │
│  • Security & DevOps (by % time allocated)                      │
│  • Data governance (by TB-months used)                          │
│                                                                 │
│  ACTIVITY COST CALCULATION                                      │
│  Activity Cost = (Labor × Rate) + (GPU × Rate) + Overhead       │
│                                                                 │
│  COST PER VALUE UNIT                                            │
│  Unit Cost = Total Activity Cost / Units Produced               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Example: Coding Machine Activity Costing

| Activity | Cost Driver | Example Calculation |
|----------|-------------|---------------------|
| **Proof of Concept** | Hours + GPU | 40 hrs × $50 + 10 GPU hrs × $10 = $2,100 |
| **Feature Delivery** | Story points | 8 points × $500/point = $4,000 |
| **Integration** | API calls | 10,000 calls × $0.05/call = $500 |
| **Maintenance** | Tickets resolved | 20 tickets × $100/ticket = $2,000 |

**Unit Cost**: Total costs / Number of deployable modules

---

## Internal Transfer Pricing Between Machines

### Pricing Mechanism

```
┌─────────────────────────────────────────────────────────────────┐
│              INTERNAL TRANSFER PRICING MODEL                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  FORMULA:                                                       │
│  Internal Price = Cost + Small Margin (5-15%)                   │
│                                                                 │
│  RATIONALE:                                                     │
│  • Prevents overuse of internal resources                       │
│  • Forces strategic prioritization                              │
│  • Reveals real economics of operations                         │
│  • Enables profitability analysis                               │
│                                                                 │
│  EXAMPLE:                                                       │
│  Coding Machine builds tool for Recommendation Engine           │
│  • Coding Machine Cost: $10,000                                 │
│  • Internal Margin: 10%                                         │
│  • Transfer Price: $11,000 (charged to Rec. Engine)            │
│                                                                 │
│  EXTERNAL COMPARISON:                                           │
│  • Internal price: Cost + 5-15%                                 │
│  • External market price: Cost + 30-50%                         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Inter-Machine Dependencies and Pricing

```
EXAMPLE INTERACTION FLOW:

1. Recommendation Engine needs data processing
   → Pays Mujarrad for data pipeline
   → Transfer: $5,000 (Mujarrad's cost + 10%)

2. Coding Machine builds feature using Recommendation Engine
   → Pays Rec. Engine for matching algorithm access
   → Transfer: $3,000 (Rec. Engine's cost + 10%)

3. Content Machine needs skill-matched writers
   → Pays People Machine for talent routing
   → Transfer: $2,000 (People Machine's cost + 10%)

RESULT:
• Each machine tracks internal revenue and costs
• Shadow P&L reveals true profitability
• Core Team can optimize resource allocation
```

---

## Machine-Level Shadow P&L

### Monthly Profitability Tracking

```
┌─────────────────────────────────────────────────────────────────┐
│              MACHINE SHADOW P&L (Example: Coding Machine)        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  REVENUE                                                        │
│  • External client revenue               $50,000                │
│  • Internal service revenue (transfer)    $15,000               │
│  • Retainer/maintenance revenue           $10,000               │
│  ───────────────────────────────────────────────────           │
│  TOTAL REVENUE                             $75,000              │
│                                                                 │
│  COSTS                                                          │
│  • Direct labor                          ($30,000)              │
│  • Allocated supercomputer               ($5,000)               │
│  • Software & tools                      ($3,000)               │
│  • Training & mentoring                  ($2,000)               │
│  ───────────────────────────────────────────────────           │
│  TOTAL COSTS                              ($40,000)             │
│                                                                 │
│  NET CONTRIBUTION                          $35,000              │
│                                                                 │
│  CLASSIFICATION: Profit-Generating                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Machine Classification Categories

1. **Profit-Generating**: External revenue > Total costs (e.g., Coding, People, Content)
2. **Strategic (Loss-Leader)**: Provides critical infrastructure, not yet profitable (e.g., Recommendation Engine in early stages)
3. **Infrastructure-Critical**: Foundational, may never be profit-generating but essential (e.g., Mujarrad)

---

## Validation-First Approach Across All Machines

### Methodology

```
┌─────────────────────────────────────────────────────────────────┐
│                 VALIDATION-FIRST WORKFLOW                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PHASE 1: Small Experiment                                      │
│  • Minimal viable proof-of-concept                              │
│  • Shared cost with client (low risk)                           │
│  • Fast feedback loop (days, not months)                        │
│                                                                 │
│  PHASE 2: Validation                                            │
│  • Client sees evidence of success                              │
│  • Technical feasibility confirmed                              │
│  • Cost and timeline estimates refined                          │
│                                                                 │
│  PHASE 3: Scale Decision                                        │
│  • If validated: Proceed to full development                    │
│  • If not: Pivot or abandon (low sunk cost)                     │
│                                                                 │
│  BENEFITS:                                                      │
│  • Reduces risk for clients and Wider                           │
│  • Shared infrastructure lowers POC cost                        │
│  • Faster time-to-insight                                       │
│  • Quality assurance through iteration                          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Inter-Machine Intelligence Sharing

### Shared Data and Learning

```
┌─────────────────────────────────────────────────────────────────┐
│              CROSS-MACHINE INTELLIGENCE FLOW                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Mujarrad cleans data → All machines access clean datasets      │
│                                                                 │
│  Recommendation Engine learns patterns → Shared with            │
│    People Machine (talent matching) and Content Machine         │
│    (content targeting)                                          │
│                                                                 │
│  Coding Machine builds automation → All machines benefit        │
│    from shared internal tools                                   │
│                                                                 │
│  People Machine identifies skill gaps → Informs training        │
│    developed by Content Machine                                 │
│                                                                 │
│  RESULT: Compounding intelligence across entire ecosystem       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Summary: The Machine-Service Architecture

### Core Principles

1. **Specialization**: Each machine focuses on one capability domain
2. **Cost Transparency**: Activity-Based Costing reveals true economics
3. **Internal Pricing**: Transfer pricing prevents waste and enables profitability analysis
4. **Shared Infrastructure**: Supercomputer provides scalable compute for all machines
5. **Validation-First**: Small experiments before large investments
6. **Intelligence Sharing**: Data and learnings flow across all machines

### The Value Equation

```
Ecosystem Value = Σ (Machine Output) × (Shared Intelligence) × (Cost Efficiency)

Where:
  • Machine Output = Specialized capability delivery
  • Shared Intelligence = Cross-machine learning and data
  • Cost Efficiency = Internal pricing and infrastructure sharing
```

The Wider machine architecture ensures that **every capability is measurable, every cost is traceable, and every service contributes to the ecosystem's sustainable growth**, creating a self-optimizing operational engine that scales with demand while maintaining cost discipline and quality standards.
