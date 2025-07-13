**Purpose**: Technical documentation and knowledge transfer

---

@include shared/universal-constants.yml#Universal_Legend

## Command Execution
Execute: immediate. --plan→show plan first
Legend: Generated based on symbols used in command
Purpose: "[Action][Subject] in $ARGUMENTS"

Provide comprehensive explanations of concepts, code, or systems specified in $ARGUMENTS.

@include shared/flag-inheritance.yml#Universal_Always

Examples:
- `/explain --depth beginner --style tutorial "React hooks"` - Explain React hooks for beginners
- `/explain --depth advanced --visual "B-tree indexes"` - Deep dive into database indexing
- `/explain --depth expert --think "quicksort optimization"` - Algorithm explanation w/ complexity

Explanation modes:

**--depth:** Explanation depth level
- beginner: Basic concepts, simple language | intermediate: Standard technical depth
- advanced: Deep technical details | expert: Cutting-edge & internals

**--style:** Explanation style
- tutorial: Step-by-step learning | reference: Quick lookup format
- conversational: Natural dialogue | academic: Formal & thorough

**--visual:** Include visual aids
- Diagrams & flowcharts | Code examples w/ annotations
- Architecture visualizations | Sequence diagrams for flows

@include shared/research-patterns.yml#Explanation_Methodology

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates

## Graph Integration (--graph flag)

When --graph flag is present, store explanations and knowledge:

```yaml
Explanation_Graph_Storage:
  Group_ID: "project_[working_directory_name]"
  
  Concept_Documentation:
    Entities:
      - type: "Concept"
        properties: ["name", "complexity", "category", "prerequisites"]
      - type: "Example"
        properties: ["code", "language", "use_case", "explanation"]
      - type: "Reference"
        properties: ["source", "type", "relevance"]
    
    Relationships:
      - "prerequisite_of" (Concept → Concept)
      - "demonstrates" (Example → Concept)
      - "references" (Concept → Reference)
    
    Facts:
      - Key insights and learnings
      - Common misconceptions clarified
      - Best practices explained
  
  Architecture_Explanations:
    Store:
      - System design rationale
      - Pattern usage explanations
      - Technology choice reasoning
      - Trade-off decisions

Example_Storage:
  - entity: "EventSourcingPattern"
    type: "Concept"
    properties:
      complexity: "advanced"
      category: "architecture_pattern"
      
  - fact: "Event sourcing provides complete audit trail but increases storage requirements by ~3x"
  
  - procedure: "To implement event sourcing: 1) Define events, 2) Create event store, 3) Build projections, 4) Handle eventual consistency"
```

@include shared/graph-integration.yml#Documentation_Commands