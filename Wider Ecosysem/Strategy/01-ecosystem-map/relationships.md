# Wider Ecosystem Relationships Map

## Overview

This document maps the interconnections between all Wider ecosystem components, showing how value, data, and governance flow through the system.

---

## Core Relationship Matrix

### Environment ↔ Environment Relationships

```
                    Community    Hub    Network    Portal    Marketplace    Labs
Community              —         ◄►       ◄►        ◄►          ◄►          ◄►
Hub                   ◄►         —        ◄►        ◄►          ◄►          ◄►
Network               ◄►        ◄►         —        ◄►          ◄►          ◄►
Portal                ◄►        ◄►        ◄►         —          ◄►          ◄
Marketplace           ◄►        ◄►        ◄►        ◄►           —          ◄►
Labs                  ◄►        ◄►        ◄►         ◄          ◄►           —

◄► = Bidirectional    ◄ = Receives from    ► = Sends to
```

---

## Detailed Relationship Descriptions

### 1. Community ↔ Network

| Flow Direction | What Flows | Description |
|----------------|------------|-------------|
| Community → Network | Verified Profiles | Members showcase skills, become eligible for missions |
| Network → Community | Reputation Data | Completed projects update portfolio, build social credit |

**Integration Point:** Wider Network Badge earned through Community profile → Training → Certification

---

### 2. Hub ↔ Network

| Flow Direction | What Flows | Description |
|----------------|------------|-------------|
| Hub → Network | Opportunities | B2B projects flow to execution layer |
| Network → Hub | Capabilities | Available talent and team capacity |

**Integration Point:** Recommendation Engine matches Hub opportunities to Network members

---

### 3. Hub ↔ Community

| Flow Direction | What Flows | Description |
|----------------|------------|-------------|
| Hub → Community | Partnership Visibility | Business success stories amplify personal brands |
| Community → Hub | Team Formation | Individual profiles combine into integrated teams |

**Integration Point:** Company capability pages built from aggregated member profiles

---

### 4. Portal ↔ All Environments

| Flow Direction | What Flows | Description |
|----------------|------------|-------------|
| Portal → Hub | Client Demand | Qualified leads enter business integration |
| Portal → Network | Project Requests | Direct mission assignments |
| All → Portal | Activity Data | Real-time metrics, success stories, member counts |

**Integration Point:** Portal serves as unified client-facing window into ecosystem activity

---

### 5. Marketplace ↔ Network

| Flow Direction | What Flows | Description |
|----------------|------------|-------------|
| Marketplace → Network | Asset Tools | Reusable code, templates for mission delivery |
| Network → Marketplace | Created Assets | Project outputs become tradable products |

**Integration Point:** "Wider Prime" badge validates marketplace listings

---

### 6. Labs ↔ Machines

| Flow Direction | What Flows | Description |
|----------------|------------|-------------|
| Labs → Machines | AI Models | Trained models deployed as machine capabilities |
| Machines → Labs | Production Data | Real-world usage data improves model training |

**Integration Point:** R&D to production pipeline via supercomputer infrastructure

---

## Governance Layer Relationships

### Concentric Flow Model

```
┌─────────────────────────────────────────────────────────────┐
│                     HUB PARTNERS                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                  CLIENT STAFF                          │  │
│  │  ┌─────────────────────────────────────────────────┐  │  │
│  │  │              NETWORK MEMBERS                     │  │  │
│  │  │  ┌───────────────────────────────────────────┐  │  │  │
│  │  │  │             VOLUNTEERS                     │  │  │  │
│  │  │  │  ┌─────────────────────────────────────┐  │  │  │  │
│  │  │  │  │           INTERNS                    │  │  │  │  │
│  │  │  │  │  ┌───────────────────────────────┐  │  │  │  │  │
│  │  │  │  │  │         CORE TEAM              │  │  │  │  │  │
│  │  │  │  │  │  (Governance & Strategy)       │  │  │  │  │  │
│  │  │  │  │  └───────────────────────────────┘  │  │  │  │  │
│  │  │  │  └─────────────────────────────────────┘  │  │  │  │
│  │  │  └───────────────────────────────────────────┘  │  │  │
│  │  └─────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘

OUTWARD FLOW →→→ : Standards, Pricing, KPIs, Quality, Governance
←←← INWARD FLOW  : Capital, Value, Opportunities, Data
```

---

### Layer-to-Layer Relationships

#### Core Team ↔ Interns
| Aspect | Relationship |
|--------|--------------|
| Authority | Core Team supervises intern assignments |
| Economic | Stipends, credits flow from Core Team |
| Value | Research, content, support flows to Core Team |

#### Interns ↔ Volunteers
| Aspect | Relationship |
|--------|--------------|
| Progression | Interns may become Volunteers or skip to Members |
| Collaboration | Both contribute non-cash value to ecosystem |
| Competition | Points system creates healthy progression pressure |

#### Volunteers ↔ Network Members
| Aspect | Relationship |
|--------|--------------|
| Pathway | Volunteers can progress to paid Member status |
| Trust | Volunteer moderation validates Member quality |
| Economy | Members earn credits; Volunteers earn points |

#### Network Members ↔ Client Staff
| Aspect | Relationship |
|--------|--------------|
| Delivery | Members execute projects for Client budgets |
| Approval | Clients trigger milestone-based payments |
| Quality | Client satisfaction affects Member reputation |

#### Client Staff ↔ Hub Partners
| Aspect | Relationship |
|--------|--------------|
| Onboarding | Hub Partners bring Clients into ecosystem |
| Local Trust | Regional Partners vouch for local Clients |
| Revenue | Both inject capital that flows inward |

---

## Machine ↔ Machine Relationships

### Inter-Machine Dependencies

```
┌──────────────────────────────────────────────────────────┐
│                    MUJARRAD (Data)                        │
│         Foundation: Cleans/governs data for all          │
└────────────────────────┬─────────────────────────────────┘
                         │
         ┌───────────────┼───────────────┐
         ▼               ▼               ▼
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│ Recommend.  │  │   People    │  │  Content    │
│   Engine    │  │  Machine    │  │  Machine    │
└──────┬──────┘  └──────┬──────┘  └──────┬──────┘
       │                │                │
       └────────────────┼────────────────┘
                        ▼
              ┌─────────────────┐
              │  Coding Machine │
              │ (Integrates all │
              │   for delivery) │
              └─────────────────┘
```

### Transfer Pricing Matrix

| Provider Machine | Consumer Machine | Price Formula |
|------------------|------------------|---------------|
| Mujarrad | Recommendation | Cost + 10% margin |
| Mujarrad | People | Cost + 10% margin |
| Mujarrad | Content | Cost + 10% margin |
| Recommendation | Coding | Cost + 15% margin |
| People | Coding | Cost + 10% margin |
| Content | Coding | Cost + 5% margin |
| Coding | Network Delivery | Project-based allocation |

---

## Dual Currency Flow Relationships

### Credits (Hard Currency) Flow

```
INJECTION → Client deposits
            Member purchases
            Partner pre-purchases

CIRCULATION → Platform fees
              Machine capacity reservation
              Premium features
              Project payments

EXTRACTION → Member earnings
             Partner revenue share
             Service redemption
```

### Points (Soft Currency) Flow

```
EARNING → Mentoring
          Moderation
          Knowledge sharing
          Peer reviews
          Quality contributions

INFLUENCE → Lower platform fees
            Priority project access
            Governance participation
            Grant eligibility
            Role progression

NOTE: Points NEVER convert to Credits
      Points ONLY influence Credit flow paths
```

---

## Rise Components Relationships

### Wider Rise Ecosystem

```
┌─────────────────────────────────────────────────────┐
│                    WIDER RISE                        │
│                                                     │
│  ┌───────────┐    ┌───────────┐    ┌───────────┐   │
│  │  Ventures │────│    VCs    │────│   Tribes  │   │
│  │ (Support) │    │ (Capital) │    │ (Family)  │   │
│  └─────┬─────┘    └─────┬─────┘    └─────┬─────┘   │
│        │                │                │         │
│        └────────────────┼────────────────┘         │
│                         ▼                          │
│  ┌─────────────────────────────────────────────┐   │
│  │              WIDER SMITH                     │   │
│  │         (Human Development Engine)          │   │
│  └─────────────────────┬───────────────────────┘   │
│                        ▼                           │
│  ┌─────────────────────────────────────────────┐   │
│  │              WIDER GROW                      │   │
│  │         (Talent Cultivation)                │   │
│  └─────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
```

### Rise ↔ Network Integration

| Rise Component | Network Relationship |
|----------------|----------------------|
| Ventures | Provides digital/human/network capital to startup members |
| VCs | Validates startups, prepares for investor network access |
| Tribes | Decentralized funding for members lacking central access |
| Smith | Forges raw members into verified Network quality |
| Grow | Cultivates interns into contributing Network Members |

---

## Cross-Component Data Flows

### Identity Data Flow
```
Community (Profile) → All environments access unified identity
                    → Single sign-on across ecosystem
                    → Skills/contributions visible everywhere
```

### Reputation Data Flow
```
Network (Delivery) → Community (Portfolio update)
                   → Marketplace (Seller rating)
                   → Hub (Capability verification)
```

### Financial Data Flow
```
Client Payment → Platform escrow
              → Milestone verification
              → Machine cost allocation (ABC)
              → Member payment release
              → Platform fee capture
```

### Quality Data Flow
```
Client Approval → Member reputation
               → Machine performance metrics
               → Hub partner KPIs
               → Ecosystem trust signals
```

---

## Summary: Relationship Principles

1. **Everything Connected**: No isolated components; all feed into each other
2. **Bidirectional Value**: Relationships create value in both directions
3. **Layered Trust**: Inner layers validate outer; outer layers expand reach
4. **Economic Alignment**: Transfer pricing ensures fair internal economics
5. **Unified Identity**: Single profile powers all relationships
6. **Points Influence Credits**: Reputation shapes economic opportunity

---

*Last Updated: 2026-01-27*
