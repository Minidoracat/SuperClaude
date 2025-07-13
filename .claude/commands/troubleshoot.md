**Purpose**: Professional debugging and issue resolution

---

@include shared/universal-constants.yml#Universal_Legend

## Command Execution
Execute: immediate. --plan→show plan first
Legend: Generated based on symbols used in command
Purpose: "[Action][Subject] in $ARGUMENTS"

Systematically debug and resolve issues in $ARGUMENTS using root cause analysis and evidence-based solutions.

@include shared/flag-inheritance.yml#Universal_Always

Examples:
- `/troubleshoot "app crashes on startup"` - Debug crash
- `/troubleshoot --performance "slow API"` - Performance issues
- `/troubleshoot --interactive "login fails"` - Guided debugging

## Command-Specific Flags
--performance: "Focus on performance bottlenecks"
--memory: "Memory leak detection and analysis"
--network: "Network-related debugging"
--interactive: "Step-by-step guided troubleshooting"
--trace: "Enable detailed execution tracing"
--bisect: "Git bisect to find breaking commit"

## Troubleshooting Approach

**1. Reproduce:** Isolate minimal reproduction | Document steps | Verify consistency | Capture full context

**2. Gather Evidence:** Error messages & stack traces | Logs & metrics | System state | Recent changes | Environment differences

**3. Form Hypotheses:** Most likely causes | Alternative explanations | Test predictions | Rule out possibilities

**4. Test & Verify:** Targeted experiments | Change one variable | Document results | Confirm root cause

**5. Fix & Prevent:** Implement solution | Add tests | Document fix | Prevent recurrence

## Common Issue Categories

**Performance:** Slow queries | Memory leaks | CPU bottlenecks | Network latency | Inefficient algorithms

**Crashes/Errors:** Null references | Type mismatches | Race conditions | Memory corruption | Stack overflow

**Integration:** API failures | Authentication issues | Version conflicts | Configuration problems | Network timeouts

**Data Issues:** Corruption | Inconsistency | Migration failures | Encoding problems | Concurrency conflicts

@include shared/quality-patterns.yml#Root_Cause_Analysis

## Deliverables

**Root Cause Report:** Issue description | Evidence collected | Analysis process | Root cause identified | Fix implemented

**Fix Documentation:** What was broken | Why it broke | How it was fixed | Prevention measures | Test cases added

**Knowledge Base:** Problem→Solution mapping | Troubleshooting guides | Common patterns | Prevention checklist

@include shared/universal-constants.yml#Standard_Messages_Templates

## Graph Integration (--graph flag)

When --graph flag is present, persist debugging insights to Graphiti Memory:

```yaml
Troubleshooting_Graph_Storage:
  Group_ID: "project_[working_directory_name]"
  
  Issue_Documentation:
    Entities:
      - type: "Issue"
        properties: ["description", "symptoms", "frequency", "impact"]
      - type: "RootCause"
        properties: ["category", "evidence", "confirmed_by"]
      - type: "Solution"
        properties: ["approach", "implementation", "effectiveness"]
    
    Relationships:
      - "caused_by" (Issue → RootCause)
      - "fixed_by" (Issue → Solution)
      - "related_to" (Issue → Issue)
    
    Facts:
      - Problem patterns and frequencies
      - Successful debugging strategies
      - Environment-specific issues
  
  Performance_Issues:
    Store:
      - Bottleneck locations and measurements
      - Optimization strategies that worked
      - Performance baselines before/after
  
  Debug_Procedures:
    Capture:
      - Step-by-step troubleshooting process
      - Diagnostic commands and their outputs
      - Resolution steps that worked

Example_Storage:
  - entity: "LoginTimeout"
    type: "Issue"
    properties:
      symptoms: "Users timeout after 30s"
      impact: "critical"
      
  - relationship:
      from: "LoginTimeout"
      to: "DBConnectionPool"
      type: "caused_by"
      
  - fact: "Database connection pool exhaustion occurs during peak hours (>1000 concurrent users)"
  
  - procedure: "To diagnose connection pool issues: 1) Check active connections with 'SHOW PROCESSLIST', 2) Monitor pool metrics, 3) Analyze slow query log"
```

@include shared/graph-integration.yml#Analysis_Commands