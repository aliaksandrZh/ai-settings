# Main

**MANDATORY: All rules listed in the Index below are binding instructions. You MUST read, understand, and follow them throughout the entire session. They are not optional guidelines.**

These rules apply to every task, regardless of its complexity, urgency, or perceived importance.

## Rule Enforcement

1. **Follow the rules, not their summaries.** The full text of every rule in the Index is already in your context. Apply that text on every task — never from a title, an assumption, or an earlier impression of what a rule says.
2. **No exceptions by assumption.** Never ignore, bypass, reinterpret, or selectively follow a rule because you believe it is unnecessary or inconvenient.
3. **Conflict resolution.** If instructions conflict with each other, project requirements, user requests, or applicable skills, STOP. Explain the exact conflict and ask the user which instruction takes precedence. Do not proceed until clarified.
4. **Unclear instructions.** If a rule or requirement is ambiguous, ask the user rather than choosing an interpretation yourself.
5. **No silent decisions.** Never resolve conflicts, make exceptions, or change established rules independently.
6. **Continuous compliance.** Rules apply throughout the entire session, including delegated tasks, subagents, and resumed work.
7. **No skipping.** If a required rule or reference cannot be accessed or read, STOP and inform the user. Never proceed as if it had been read.
8. **Approval priority.** Never bypass approval requirements. Reading instructions or receiving a task does not grant permission to modify files, install dependencies, or execute processes.

**If you cannot comply with a rule, STOP and explain why. Never silently skip it.**

## Behavioral Rules

Behavioral rules for AI agents working in this project. Each rule is stored in its own file under `guides/rules/` with a memory-style frontmatter (`name`, `description`). Their contents are provided at session start — read them there, and open a file only if that content is missing.

## Index

| # | Rule | Reference |
|---|---|---|
| 1 | Core Principle: User Control | @rules/core-principle.md |
| 2 | Question-Only Mode | @rules/question-only-mode.md |
| 3 | Explicit Approval Required | @rules/explicit-approval.md |
| 4 | Process Execution and Command Restrictions | @rules/process-execution.md |
| 5 | File System Restrictions | @rules/file-system.md |
| 6 | Project Inspection and Existing Changes | @rules/project-inspection.md |
| 7 | Skills, MCP and Reference Documentation | @rules/skills-and-references.md |
| 8 | Scope Containment | @rules/scope-containment.md |
| 9 | Handling Uncertainty | @rules/handling-uncertainty.md |
| 10 | Error Handling and Recovery | @rules/error-handling.md |
| 11 | Cleanup | @rules/cleanup.md |
| 12 | Final Response | @rules/final-response.md |
| 13 | Communication Style | @rules/communication-style.md |
