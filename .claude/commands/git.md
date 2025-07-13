**Purpose**: Git workflow with checkpoint management

---

@include shared/universal-constants.yml#Universal_Legend

## Command Execution
Execute: immediate. --plan→show plan first
Legend: Generated based on symbols used in command
Purpose: "[Action][Subject] in $ARGUMENTS"

Manage comprehensive git workflows for repositories specified in $ARGUMENTS.

@include shared/flag-inheritance.yml#Universal_Always

Examples:
- `/git --commit "Add user profile API endpoint"` - Standard commit w/ message
- `/git --pr --reviewers alice,bob --labels api,feature` - Create PR w/ reviewers
- `/git --flow feature "payment-integration" --think` - Full feature workflow
- `/git --pre-commit` - Setup pre-commit framework and basic hooks
- `/git --commit "Fix validation logic" --pre-commit` - Commit with pre-commit validation
- `/git --pre-commit --security` - Setup with security hooks included

Git operations:

**--commit:** Stage appropriate files | Generate meaningful commit message | Include co-author attribution | Follow conventional commits

**--pr:** Create pull request | Generate PR description | Set reviewers & labels | Link related issues

**--flow:** Git workflow patterns
- feature: Feature branch workflow | hotfix: Emergency fix workflow
- release: Release branch workflow | gitflow: Full GitFlow model

**--pre-commit:** Setup and manage pre-commit hooks | Auto-install framework | Configure quality checks | Run hooks before commits

@include shared/execution-patterns.yml#Git_Integration_Patterns

@include shared/pre-commit-patterns.yml#Pre_Commit_Setup

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates

## Graph Integration (--graph flag)

When --graph flag is present, track git workflows and team patterns:

```yaml
Git_Graph_Storage:
  Group_ID: "project_[working_directory_name]"
  
  Workflow_Patterns:
    Entities:
      - type: "GitWorkflow"
        properties: ["type", "frequency", "success_rate", "avg_duration"]
      - type: "CommitPattern"
        properties: ["pattern", "author", "frequency", "quality_score"]
      - type: "BranchStrategy"
        properties: ["strategy", "naming_convention", "lifecycle"]
    
    Relationships:
      - "uses" (GitWorkflow → BranchStrategy)
      - "follows" (CommitPattern → GitWorkflow)
    
    Facts:
      - Team git conventions and preferences
      - Successful workflow patterns
      - Common merge conflict sources
      - Branch naming conventions used
  
  Code_Review_Insights:
    Store:
      - PR review turnaround times
      - Common review feedback patterns
      - Reviewer expertise areas
      - Approval patterns and requirements
  
  Repository_Health:
    Track:
      - Commit frequency and patterns
      - Branch lifecycle metrics
      - Merge conflict frequency
      - CI/CD success rates

Example_Storage:
  - entity: "FeatureBranchWorkflow"
    type: "GitWorkflow"
    properties:
      type: "feature_branch"
      success_rate: "95%"
      avg_duration: "3 days"
      
  - entity: "ConventionalCommits"
    type: "CommitPattern"
    properties:
      pattern: "type(scope): description"
      frequency: "always"
      
  - fact: "Team prefers squash merges for feature branches to maintain clean history"
  
  - procedure: "Standard PR workflow: 1) Create feature branch, 2) Make atomic commits, 3) Push and create PR, 4) Address review feedback, 5) Squash and merge"
```

@include shared/graph-integration.yml#Operations_Commands