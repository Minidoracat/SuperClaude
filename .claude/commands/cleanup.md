**Purpose**: Project cleanup and maintenance

---

@include shared/universal-constants.yml#Universal_Legend

## Command Execution
Execute: immediate. --plan→show plan first
Legend: Generated based on symbols used in command
Purpose: "[Action][Subject] in $ARGUMENTS"

Cleanup project files, dependencies & artifacts in $ARGUMENTS.

@include shared/flag-inheritance.yml#Universal_Always

Examples:
- `/cleanup --code --dry-run` - Preview code cleanup changes
- `/cleanup --deps --all` - Remove unused dependencies
- `/cleanup --files --watch` - Continuous file cleanup

Cleanup modes:

**--code:** Remove unused imports & dead code | Clean console.log & debug code | Remove commented blocks | Fix style inconsistencies | Remove TODO>30 days

**--files:** Remove build artifacts & temp files | Clean node_modules if corrupted | Remove logs & cache dirs | Clean test outputs | Remove OS files (.DS_Store, thumbs.db)

**--deps:** Remove unused deps from package.json | Update vulnerable deps | Clean duplicate deps | Optimize dep tree | Check outdated packages

**--git:** Remove untracked files (w/ confirmation) | Clean merged branches | Remove large/unwanted files from history | Optimize git (.git/objects cleanup) | Clean stale refs

**--cfg:** Remove deprecated cfg settings | Clean unused env vars | Update outdated cfg formats | Validate cfg consistency | Remove duplicate entries

**--all:** Comprehensive cleanup all areas | Generate detailed report | Suggest maintenance schedule | Provide perf impact analysis

**--dry-run:** Show what would be cleaned w/o changes | Estimate space savings & perf impact | ID risks before cleanup

**--watch:** Monitor & auto-clean new artifacts | Continuous cleanup during dev | Prevent temp file accumulation | Real-time maintenance

## Integration & Best Practices

@include shared/research-patterns.yml#Mandatory_Research_Flows

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates

## Graph Integration (--graph flag)

When --graph flag is present, track cleanup patterns and technical debt:

```yaml
Cleanup_Graph_Storage:
  Group_ID: "project_[working_directory_name]"
  
  Technical_Debt_Tracking:
    Entities:
      - type: "TechnicalDebt"
        properties: ["category", "location", "impact", "effort", "cleaned"]
      - type: "CleanupOperation"
        properties: ["type", "files_affected", "size_saved", "date"]
      - type: "MaintenancePattern"
        properties: ["pattern", "frequency", "automation_possible"]
    
    Relationships:
      - "resolves" (CleanupOperation → TechnicalDebt)
      - "prevents" (MaintenancePattern → TechnicalDebt)
    
    Facts:
      - Common sources of technical debt
      - Effective cleanup strategies
      - Maintenance schedules that work
      - Impact of regular cleanup on performance
  
  Cleanup_History:
    Store:
      - Files and patterns frequently cleaned
      - Dependencies removed and why
      - Space savings achieved
      - Performance improvements from cleanup

Example_Storage:
  - entity: "UnusedImports"
    type: "TechnicalDebt"
    properties:
      category: "code_quality"
      impact: "low"
      effort: "automated"
      
  - entity: "DependencyCleanup20240115"
    type: "CleanupOperation"
    properties:
      type: "dependencies"
      files_affected: 3
      size_saved: "45MB"
      
  - fact: "Running dependency cleanup monthly reduces node_modules size by average 30%"
  
  - procedure: "Automated cleanup workflow: 1) Run linter fixes, 2) Remove unused deps, 3) Clean build artifacts, 4) Optimize git history"
```

@include shared/graph-integration.yml#Operations_Commands