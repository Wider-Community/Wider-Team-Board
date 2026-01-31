# Wider Value Flow

## How Credits and Points Move Through the System

The Wider ecosystem operates on a dual-currency model where Credits (hard currency) represent financial value and Points (soft currency) represent trust, contribution, and authority. This document maps how both currencies flow through the closed-loop economic system.

---

## Dual Currency System Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     DUAL CURRENCY MECHANISM                                  │
└─────────────────────────────────────────────────────────────────────────────┘

        ╔═══════════════════════════════╗         ╔═══════════════════════════════╗
        ║   CREDITS (Hard Currency)     ║         ║   POINTS (Soft Currency)      ║
        ╠═══════════════════════════════╣         ╠═══════════════════════════════╣
        ║                               ║         ║                               ║
        ║  Nature: Financial/Auditable  ║         ║  Nature: Behavioral/Trust     ║
        ║                               ║         ║                               ║
        ║  Acquisition:                 ║         ║  Acquisition:                 ║
        ║  • Purchased with cash        ║         ║  • Earned via contribution    ║
        ║  • Earned via high-value work ║         ║  • Mentoring & sharing        ║
        ║                               ║         ║  • Peer reviews               ║
        ║  Use Cases:                   ║         ║                               ║
        ║  • Pay platform fees          ║         ║  Use Cases:                   ║
        ║  • Reserve compute hours      ║         ║  • Unlock governance rights   ║
        ║  • Buy premium placement      ║         ║  • Priority queue access      ║
        ║  • Acquire goods/services     ║         ║  • Grant eligibility          ║
        ║                               ║         ║  • Reputation weighting       ║
        ║  Accounting:                  ║         ║                               ║
        ║  Platform liability until     ║         ║  Accounting:                  ║
        ║  redeemed (like gift cards)   ║         ║  Off-balance-sheet metric     ║
        ║                               ║         ║  (not financial asset)        ║
        ╚═══════════════════════════════╝         ╚═══════════════════════════════╝
                      │                                         │
                      │                                         │
                      └─────────► NEVER CONVERT ◄───────────────┘
                                        │
                                        ▼
                            Points influence Credit flow
                        (e.g., high points → lower fees)
```

---

## Complete Value Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                   CLIENT → PROJECT → MACHINES → MEMBERS                      │
│                         (Primary Value Flow)                                 │
└─────────────────────────────────────────────────────────────────────────────┘

    ┌────────────┐
    │   CLIENT   │  Deposits Credits (purchased with cash)
    │   STAFF    │  or directly pays project budget
    └──────┬─────┘
           │
           │ (1) Project Funding: $100,000
           │     Converted to Credits or held as budget
           │
           ▼
    ┌────────────┐
    │  PROJECT   │  Budget allocated across:
    │   BUDGET   │  • Member compensation (70%)
    └──────┬─────┘  • Machine costs (15%)
           │        • Platform fees (10%)
           │        • Reserve/contingency (5%)
           │
           ├────────────────────────────┐
           │                            │
           ▼                            ▼
    ┌────────────┐              ┌─────────────┐
    │  MACHINES  │              │   MEMBERS   │
    │ (Internal  │              │  (Network   │
    │  Services) │              │  Execution) │
    └──────┬─────┘              └──────┬──────┘
           │                            │
           │ (2) Machine Costs:         │ (3) Member Earnings:
           │     $15,000 in credits     │     $70,000 in credits
           │     • Mujarrad (data): $3K │     • Dev team: $40K
           │     • Rec. Engine: $4K     │     • Designer: $15K
           │     • People Machine: $2K  │     • QA: $10K
           │     • Content: $3K         │     • PM: $5K
           │     • Coding: $3K          │
           │                            │
           ▼                            ▼
    ┌────────────┐              ┌─────────────┐
    │ MACHINE    │              │   MEMBER    │
    │ COST       │              │  WALLETS    │
    │ RECOVERY   │              │             │
    └────────────┘              └─────────────┘
```

---

## Detailed Credit Flow by Participant Type

### 1. Client Credit Flow

```
CLIENT INJECTION
    │
    ├──► Purchase Credits (Cash → Credits)
    │    Example: $100,000 → 100,000 Credits
    │
    ├──► Fund Project Budget
    │    Credits locked in escrow until milestones
    │
    └──► Milestone Approvals
         Credits released to members upon approval

ACCOUNTING TREATMENT:
  When purchased:  Debit: Cash / Credit: Deferred Revenue (Liability)
  When redeemed:   Debit: Deferred Revenue / Credit: Revenue
  If expired:      Debit: Deferred Revenue / Credit: Breakage Income
```

### 2. Network Member Credit Flow

```
MEMBER EARNING
    │
    ├──► Pay Membership Fee
    │    Debit from member wallet: 1,000 Credits/year
    │
    ├──► Pay Certification Fee
    │    Debit from member wallet: 500 Credits per certification
    │
    ├──► Earn Project Revenue
    │    Credit to member wallet upon milestone approval
    │    Example: 10,000 Credits for completed deliverable
    │
    ├──► Spend on Premium Features
    │    • Featured profile: 200 Credits/month
    │    • Priority routing: 500 Credits/project
    │    • Additional compute: Variable pricing
    │
    └──► Withdraw or Reinvest
         • Withdraw to cash (platform fee applies)
         • Reinvest in ecosystem opportunities

CREDIT MULTIPLIER:
  High Points → Fee discounts (e.g., 5-20% reduction)
  Low Points → Higher collateral requirements
```

### 3. Machine Credit Flow (Internal Transfer Pricing)

```
MACHINE COST ACCOUNTING
    │
    ├──► Direct Costs
    │    • Labor hours × hourly rate
    │    • GPU hours × GPU rate
    │    • Software licenses
    │
    ├──► Allocated Overhead
    │    • Supercomputer infrastructure
    │    • DevOps, security, data governance
    │    Allocation driver: GPU-hours or API calls
    │
    ├──► Internal Service Pricing
    │    When Machine A serves Machine B:
    │    Price = Cost + Margin (5-15%)
    │    Example: Coding Machine builds tool for Rec. Engine
    │              Cost: 10,000 Credits + 10% = 11,000 Credits
    │
    └──► External Service Revenue
         When serving external clients:
         Market rate pricing (typically cost + 30-50%)

MACHINE P&L (Shadow Accounting):
  Revenue: External client revenue + Internal service revenue
  Cost:    Direct costs + Allocated infrastructure
  Result:  Classify as profit-generating, strategic, or infrastructure-critical
```

### 4. Intern & Volunteer Credit/Point Flow

```
INTERNS
    │
    ├──► Earn Limited Credits
    │    For milestone-based supervised delivery
    │    Example: 500 Credits for completed research task
    │
    ├──► Earn Points (Primary)
    │    For participation, learning progress, reliability
    │    Points → Future eligibility for paid roles
    │
    └──► Access to Subsidized Learning
         Low-cost or free access to:
         • Platform tools
         • Mentorship
         • Training programs

VOLUNTEERS
    │
    ├──► Earn ZERO Credits (by default)
    │    Exception: Can use earned credits to hire interns
    │
    ├──► Earn Points (Primary Reward)
    │    For moderation, validation, content contribution
    │
    └──► Points Unlock
         • Priority project access
         • Future paid role eligibility
         • Governance participation
```

### 5. Hub Partner Credit Flow

```
HUB PARTNER REVENUE SHARING
    │
    ├──► Collect Local Revenue
    │    From members and clients in their hub
    │    Example: $50,000 in monthly transactions
    │
    ├──► Remit Share to Core Team
    │    Agreed percentage (e.g., 20-30%)
    │    Example: $10,000 to Core Team
    │
    ├──► Retain Local Share
    │    Keep 70-80% for local operations
    │    Example: $40,000 for partner
    │
    ├──► Pre-Purchase Credits (Optional)
    │    For regional operational efficiency
    │    Bulk discount available
    │
    └──► Earn Points
         For ecosystem growth, compliance, quality enforcement
         Points influence future revenue-sharing terms
```

---

## Internal Transfer Pricing Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                   MACHINE-TO-MACHINE CREDIT FLOW                             │
│                      (Internal Transfer Pricing)                             │
└─────────────────────────────────────────────────────────────────────────────┘

    Example: Coding Machine builds automation for Recommendation Engine

    ┌─────────────────┐
    │ CODING MACHINE  │
    │                 │  Costs incurred:
    │ Cost Center #5  │  • 80 hours × $50/hr = $4,000
    └────────┬────────┘  • 20 GPU hours × $10/hr = $200
             │           • Total Cost: $4,200
             │
             │ (1) Internal Transfer Price
             │     Cost + 10% margin = $4,620
             │
             ▼
    ┌─────────────────┐
    │ RECOMMENDATION  │
    │    ENGINE       │  Receives tooling
    │                 │  Charged: 4,620 Credits
    │ Cost Center #2  │
    └────────┬────────┘
             │
             │ (2) Rec. Engine uses tool to serve
             │     External client project
             │
             ▼
    ┌─────────────────┐
    │ CLIENT PROJECT  │  Charged market rate:
    │                 │  $15,000 (Cost + 50% margin)
    │ Project Budget  │  Revenue to Rec. Engine
    └─────────────────┘

RATIONALE FOR INTERNAL PRICING:
  • Prevents overuse of shared resources
  • Forces strategic prioritization
  • Reveals true economics of each machine
  • Enables profitability analysis per machine
```

---

## Closed-Loop Economic System

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       THE CLOSED-LOOP CYCLE                                  │
└─────────────────────────────────────────────────────────────────────────────┘

         ┌──────────────────────────────────────────┐
         │                                          │
         │    (1) CAPITAL INJECTION                 │
         │    Client deposits cash or credits       │
         │                                          │
         └────────────────┬─────────────────────────┘
                          │
                          ▼
         ┌──────────────────────────────────────────┐
         │                                          │
         │    (2) PROJECT ALLOCATION                │
         │    Credits distributed across:           │
         │    • Members (labor)                     │
         │    • Machines (tools/automation)         │
         │    • Platform (fees)                     │
         │                                          │
         └────────────────┬─────────────────────────┘
                          │
                          ▼
         ┌──────────────────────────────────────────┐
         │                                          │
         │    (3) VALUE CREATION                    │
         │    • Members execute deliverables        │
         │    • Machines provide automation         │
         │    • Quality validated through Points    │
         │                                          │
         └────────────────┬─────────────────────────┘
                          │
                          ▼
         ┌──────────────────────────────────────────┐
         │                                          │
         │    (4) MILESTONE APPROVAL                │
         │    Client staff approves work            │
         │    Triggers credit release               │
         │                                          │
         └────────────────┬─────────────────────────┘
                          │
                          ▼
         ┌──────────────────────────────────────────┐
         │                                          │
         │    (5) CREDIT DISTRIBUTION               │
         │    • Members receive credits             │
         │    • Machines recover costs              │
         │    • Platform captures fees              │
         │                                          │
         └────────────────┬─────────────────────────┘
                          │
                          ▼
         ┌──────────────────────────────────────────┐
         │                                          │
         │    (6) REINVESTMENT OR WITHDRAWAL        │
         │    • Members reinvest in ecosystem       │
         │    • Or withdraw to cash                 │
         │    • Points influence future rates       │
         │                                          │
         └────────────────┬─────────────────────────┘
                          │
                          └──────────► CYCLE REPEATS
```

---

## Point Influence on Credit Flow

### How Points Shape Credit Paths (Without Converting)

```
HIGH POINTS → BETTER CREDIT TERMS
    │
    ├──► Lower Platform Fees
    │    Standard: 10% / High Points: 5-7%
    │
    ├──► Priority Project Access
    │    High-value projects routed first
    │
    ├──► Subsidized Credits
    │    Eligibility for grants or scholarships
    │    Example: 1,000 free credits for contributors
    │
    └──► Better Pricing Tiers
         Volume discounts, bulk credit purchases

LOW POINTS → RESTRICTED ACCESS
    │
    ├──► Higher Platform Fees
    │    Standard: 10% / Low Points: 12-15%
    │
    ├──► Higher Collateral Requirements
    │    Must deposit more credits upfront
    │
    ├──► Limited Project Access
    │    Premium projects require point threshold
    │
    └──► No Subsidies
         Full market rate for all services
```

---

## Economic Interaction Flow Map

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                  COMPLETE ECONOMIC INTERACTION MAP                           │
└─────────────────────────────────────────────────────────────────────────────┘

    CORE TEAM
        │
        │ (Allocates capital to machines)
        │ (Sets internal rates)
        │
        ▼
    MACHINES ────────────► (Internal services) ────────────► NETWORK MEMBERS
        │                                                          │
        │ (Consume credits as costs)                              │ (Deliver projects)
        │                                                          │
        ▼                                                          ▼
    MACHINE COST RECOVERY                                     MEMBER EARNINGS
        │                                                          │
        │                                                          │
        └──────────────────┬───────────────────────────────────────┘
                           │
                           ▼
                    PLATFORM REVENUE
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
    RESERVES      CORE TEAM COMP     INFRASTRUCTURE
                                              │
                                              │ (Reinvested)
                                              │
                                              ▼
                                        MACHINES & TOOLS
                                              │
                                              └──► CYCLE CONTINUES


    PARALLEL FLOW (Points):

    VOLUNTEERS & INTERNS
        │
        │ (Contribute time, moderation, learning)
        │
        ▼
    EARN POINTS
        │
        ├──► Unlock governance rights
        ├──► Priority access
        └──► Future paid role eligibility
                │
                └──► TRANSITION TO PAID ROLES
                         │
                         └──► Join Credit Economy
```

---

## Revenue Recognition and Accounting

### Credit Lifecycle Accounting

```
PHASE 1: PURCHASE
  Transaction: Client buys 10,000 Credits for $10,000
  Journal Entry:
    DR: Cash                    $10,000
    CR: Deferred Revenue                $10,000
  Platform Status: Liability (owe client value)

PHASE 2: ALLOCATION
  Transaction: Credits allocated to project escrow
  Journal Entry:
    No entry (still liability, just earmarked)
  Platform Status: Liability (escrowed for project)

PHASE 3: REDEMPTION
  Transaction: 2,000 Credits redeemed for member payment
  Journal Entry:
    DR: Deferred Revenue        $2,000
    CR: Revenue                         $2,000
  Platform Status: Revenue recognized

PHASE 4: EXPIRY (if applicable)
  Transaction: 500 unused Credits expire after 24 months
  Journal Entry:
    DR: Deferred Revenue        $500
    CR: Breakage Income                 $500
  Platform Status: Profit (customer didn't use)
```

---

## Summary: The Value Flow Ecosystem

### Key Principles

1. **Credits Follow Delivery**: Money flows only when value is created and approved
2. **Points Shape Paths**: Reputation influences how credits flow, but never converts
3. **Internal Pricing**: Machines charge each other to prevent waste and reveal economics
4. **Closed-Loop**: Capital enters, circulates through machines and members, reinvests
5. **Trust Coupling**: Financial flows tightly coupled to quality signals and governance

### The Economic Formula

```
Value Creation = (Client Capital) × (Machine Efficiency) × (Member Quality) × (Point Trust)

Where:
  • Client Capital injects credits into system
  • Machine Efficiency reduces cost per unit output
  • Member Quality ensures delivery and repeat business
  • Point Trust influences routing, pricing, and opportunity access
```

The Wider value flow model ensures that **every credit, every point, and every interaction reinforces the ecosystem's long-term sustainability**, creating a self-regulating economic engine that rewards contribution, quality, and trust above all else.
