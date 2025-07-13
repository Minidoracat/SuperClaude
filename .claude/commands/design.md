**Purpose**: System architecture and API design

---

@include shared/universal-constants.yml#Universal_Legend

## Command Execution
Execute: immediate. --plan→show plan first
Legend: Generated based on symbols used in command
Purpose: "[Action][Subject] in $ARGUMENTS"

Design system architecture & APIs for $ARGUMENTS.

@include shared/flag-inheritance.yml#Universal_Always

Examples:
- `/design --api --think` - REST API design w/ patterns
- `/design --ddd --think-hard` - Deep domain modeling
- `/design --api --ddd --ultrathink` - Complete system architecture

Design modes:

**--api:** Design REST or GraphQL APIs
- w/ --openapi: Generate OpenAPI 3.0 spec | w/ --graphql: Create GraphQL schema & resolvers
- Include auth, rate limiting & error handling | Design→scalability & maintainability

**--ddd:** Apply DDD principles
- w/ --bounded-context: Define context boundaries & mappings
- Design entities, value objects & aggregates | Create domain services & events | Impl repository patterns

**--prd:** Create PRD 
- w/ --template: Use template (feature/api/integration/migration)
- Include user stories w/ acceptance criteria | Define success metrics & timelines | Document tech requirements

## Design Patterns

@include shared/architecture-patterns.yml#API_Design_Patterns

@include shared/architecture-patterns.yml#DDD_Patterns

@include shared/architecture-patterns.yml#PRD_Templates

## Integration & Best Practices

Combined modes: API+DDD: Design domain-driven APIs | API+PRD: Create API product requirements | DDD+PRD: Document domain-driven architecture | All three: Complete system design

Best practices: Start w/ user needs & business goals | Design→change & evolution | Consider non-functional early | Document decisions & rationale | Include examples & diagrams | Plan→testing & monitoring

@include shared/research-patterns.yml#Mandatory_Research_Flows

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates

## Graph Integration (--graph flag)

When --graph flag is present, persist design decisions and architecture:

```yaml
Design_Graph_Storage:
  Group_ID: "project_[working_directory_name]"
  
  Architecture_Decisions:
    Entities:
      - type: "ArchitectureDecision"
        properties: ["title", "status", "decision", "rationale", "consequences"]
      - type: "SystemComponent"
        properties: ["name", "type", "responsibility", "technology"]
      - type: "DesignPattern"
        properties: ["name", "category", "applicability", "implementation"]
    
    Relationships:
      - "uses" (SystemComponent → DesignPattern)
      - "depends_on" (SystemComponent → SystemComponent)
      - "impacts" (ArchitectureDecision → SystemComponent)
    
    Facts:
      - Design principles adopted
      - Technology stack decisions
      - Scalability requirements
      - Trade-off analyses
  
  API_Design:
    Store:
      - Endpoint definitions and purposes
      - Authentication strategies
      - Rate limiting policies
      - Error handling patterns
  
  Domain_Model:
    Capture:
      - Bounded contexts and their relationships
      - Aggregates and entities
      - Domain events and workflows
      - Ubiquitous language terms

Example_Storage:
  - entity: "MicroservicesDecision"
    type: "ArchitectureDecision"
    properties:
      decision: "Adopt microservices architecture"
      rationale: "Need independent scaling and deployment"
      consequences: "Increased complexity, need service mesh"
      
  - entity: "UserService"
    type: "SystemComponent"
    properties:
      responsibility: "User authentication and profile management"
      technology: "Node.js with Express"
      
  - relationship:
      from: "UserService"
      to: "EventSourcingPattern"
      type: "uses"
      
  - fact: "System designed for 100K concurrent users with <100ms response time"
```

@include shared/graph-integration.yml#Build_Commands