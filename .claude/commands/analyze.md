**Purpose**: Multi-dimensional code and system analysis

---

@include shared/universal-constants.yml#Universal_Legend

## Command Execution
Execute: immediate. --plan→show plan first
Legend: Generated based on symbols used in command
Purpose: "[Action][Subject] in $ARGUMENTS"

Multi-dimensional analysis on code, arch, or problem in $ARGUMENTS.

@include shared/flag-inheritance.yml#Universal_Always

Examples:
- `/analyze --code --think` - Code review w/ context
- `/analyze --arch --think-hard` - Deep arch analysis  
- `/analyze --security --ultrathink` - Comprehensive security audit

Analysis modes:

**--code:** Quality review→naming, structure, DRY, complexity | Bugs→null checks, boundaries, types | Security→injection, auth, validation | Perf→O(n²), N+1, memory

**--arch:** System design & patterns | Layer coupling | Scalability bottlenecks | Maintainability assessment | Improvement suggestions

**--profile:** CPU, memory, execution time | Network latency, DB queries | Frontend metrics | Bottleneck identification | Optimization recommendations  

**--security:** OWASP top 10 | Auth & authorization | Data handling & encryption | Attack vector identification

**--perf:** Bottleneck analysis | Algorithm complexity | DB queries & indexes | Caching strategies | Resource utilization

**--watch:** Continuous file monitoring | Real-time quality tracking | Auto re-analysis | Live metrics

**--interactive:** Guided exploration | Step-by-step fixes | Live improvement

@include shared/research-patterns.yml#Mandatory_Research_Flows

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates

## Graph Integration (--graph flag)

When --graph flag is present, store analysis results in Graphiti Memory:

```yaml
Graph_Storage_Behavior:
  Group_ID: "project_[working_directory_name]"
  
  Architecture_Analysis (--arch):
    Entities_to_Store:
      - type: "Component"
        examples: ["API Gateway", "Auth Service", "Database Layer"]
      - type: "Module" 
        examples: ["User Module", "Payment Module", "Notification Module"]
      - type: "Pattern"
        examples: ["MVC", "Repository Pattern", "Observer Pattern"]
    
    Relationships_to_Create:
      - "depends_on" (module → module dependencies)
      - "implements" (component → pattern relationships)
      - "communicates_with" (service → service interactions)
    
    Facts_to_Record:
      - Architecture decisions and rationale
      - Technology stack choices
      - Scalability considerations
  
  Code_Analysis (--code):
    Entities_to_Store:
      - type: "CodeIssue"
        properties: ["severity", "location", "suggestion"]
      - type: "CodePattern"
        properties: ["name", "usage_count", "quality_score"]
      - type: "TechDebt"
        properties: ["type", "impact", "effort_to_fix"]
    
    Facts_to_Record:
      - Code quality metrics and trends
      - Refactoring suggestions
      - Performance bottlenecks identified
  
  Security_Analysis (--security):
    Entities_to_Store:
      - type: "Vulnerability"
        properties: ["severity", "OWASP_category", "remediation"]
      - type: "SecurityControl"
        properties: ["type", "effectiveness", "coverage"]
    
    Facts_to_Record:
      - Security posture assessment
      - Compliance status
      - Risk mitigation strategies
  
  Performance_Analysis (--perf):
    Entities_to_Store:
      - type: "Bottleneck"
        properties: ["location", "impact", "optimization_suggestion"]
      - type: "Resource"
        properties: ["type", "usage", "limit"]
    
    Facts_to_Record:
      - Performance baselines
      - Optimization opportunities
      - Resource utilization patterns

Storage_Examples:
  # Example of what gets stored for architecture analysis
  - entity: "UserService"
    type: "Component"
    properties:
      technology: "Node.js"
      responsibility: "User authentication and management"
  
  - relationship:
      from: "UserService"
      to: "AuthModule"
      type: "depends_on"
      properties:
        critical: true
        
  - fact: "The system uses microservices architecture with 5 independent services"
```

@include shared/graph-integration.yml#Graph_Integration_Standards