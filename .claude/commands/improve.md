**Purpose**: Evidence-based enhancement and optimization

---

@include shared/universal-constants.yml#Universal_Legend

## Command Execution
Execute: immediate. --plan→show plan first
Legend: Generated based on symbols used in command
Purpose: "[Action][Subject] in $ARGUMENTS"

Systematically improve code quality, performance, and architecture in $ARGUMENTS using best practices and optimization techniques.

@include shared/flag-inheritance.yml#Universal_Always

Examples:
- `/improve --quality` - Code quality improvements
- `/improve --perf --iterate` - Performance optimization
- `/improve --arch --think-hard` - Architecture refactoring

## Command-Specific Flags
--quality: "Code quality improvements (readability, maintainability, DRY)"
--perf: "Performance optimizations (algorithms, caching, queries)"
--arch: "Architecture improvements (patterns, coupling, scalability)"
--refactor: "Safe refactoring preserving behavior"
--iterate: "Iterative improvement until threshold met"
--threshold: "Quality threshold (low|medium|high|perfect)"
--metrics: "Show before/after metrics"
--safe: "Conservative mode - only safe changes"

## Improvement Categories

**Code Quality:** Naming clarity | Function extraction | Duplication removal | Complexity reduction | Error handling | Type safety

**Performance:** Algorithm optimization | Query optimization | Caching strategies | Lazy loading | Memory efficiency | Parallel processing

**Architecture:** Design patterns | Dependency injection | Layer separation | Module boundaries | API design | Scalability patterns

**Maintainability:** Documentation | Test coverage | Configuration extraction | Magic number removal | Dead code elimination

## Improvement Process

**1. Analysis:** Current state assessment | Identify improvement areas | Prioritize by impact | Set measurable goals

**2. Planning:** Safe refactoring path | Preserve functionality | Incremental changes | Rollback strategy

**3. Implementation:** Small atomic changes | Continuous testing | Performance monitoring | Code review ready

**4. Validation:** Behavior preservation | Performance gains | Quality metrics | Regression testing

@include shared/quality-patterns.yml#Code_Quality_Metrics

## Deliverables

**Improved Code:** Refactored files | Preserved functionality | Enhanced quality | Better performance

**Improvement Report:** Before/after metrics | Changes summary | Performance gains | Quality improvements

**Documentation:** Refactoring decisions | Architecture changes | Performance optimizations | Future recommendations

@include shared/universal-constants.yml#Standard_Messages_Templates

## Graph Integration (--graph flag)

When --graph flag is present, store improvement patterns and outcomes:

```yaml
Improvement_Graph_Storage:
  Group_ID: "project_[working_directory_name]"
  
  Quality_Improvements:
    Entities:
      - type: "CodeSmell"
        properties: ["type", "location", "severity", "fixed"]
      - type: "RefactoringPattern"
        properties: ["name", "applicability", "impact"]
      - type: "QualityMetric"
        properties: ["metric", "before_value", "after_value"]
    
    Facts:
      - Refactoring strategies that worked
      - Quality improvements achieved
      - Team coding standards identified
  
  Performance_Optimizations:
    Entities:
      - type: "PerformanceOptimization"
        properties: ["technique", "location", "speedup", "trade_offs"]
      - type: "Benchmark"
        properties: ["operation", "before_ms", "after_ms"]
    
    Facts:
      - Optimization techniques and their effectiveness
      - Performance baselines and improvements
      - Resource usage patterns
  
  Architecture_Enhancements:
    Store:
      - Design pattern applications
      - Dependency reductions achieved
      - Module boundary improvements
      - Scalability enhancements

Example_Storage:
  - entity: "DuplicateCodeSmell"
    type: "CodeSmell"
    properties:
      location: "src/utils/validation.js"
      severity: "medium"
      fixed: true
      
  - entity: "ExtractMethod"
    type: "RefactoringPattern"
    properties:
      applicability: "functions > 20 lines"
      impact: "high readability improvement"
      
  - fact: "Extracting validation logic into separate modules reduced code duplication by 40%"
  
  - procedure: "Standard refactoring workflow: 1) Write characterization tests, 2) Extract method, 3) Verify behavior, 4) Optimize"
```

@include shared/graph-integration.yml#Build_Commands