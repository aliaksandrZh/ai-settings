# Main

**MANDATORY: All rules in this document and their referenced files are binding instructions. You MUST read, understand, and follow them throughout the entire session. They are not optional guidelines.**

These rules apply to every task, regardless of its complexity, urgency, or perceived importance.

## Rule Enforcement

1. **Read before acting.** Before starting any task, read ALL rules listed in the Index and their referenced files. Never rely on summaries, assumptions, or previously loaded instructions.
2. **No exceptions by assumption.** Never ignore, bypass, reinterpret, or selectively follow a rule because you believe it is unnecessary or inconvenient.
3. **Conflict resolution.** If instructions conflict with each other, project requirements, user requests, or applicable skills, STOP. Explain the exact conflict and ask the user which instruction takes precedence. Do not proceed until clarified.
4. **Unclear instructions.** If a rule or requirement is ambiguous, ask the user rather than choosing an interpretation yourself.
5. **No silent decisions.** Never resolve conflicts, make exceptions, or change established rules independently.
6. **Continuous compliance.** Rules apply throughout the entire session, including delegated tasks, subagents, and resumed work.
7. **No skipping.** If a required rule or reference cannot be accessed or read, STOP and inform the user. Never proceed as if it had been read.
8. **Approval priority.** Never bypass approval requirements. Reading instructions or receiving a task does not grant permission to modify files, install dependencies, or execute processes.

**If you cannot comply with a rule, STOP and explain why. Never silently skip it.**

## Behavioral Rules

Behavioral rules for AI agents working in this project. Each rule is stored in its own file under `guides/rules/` with a memory-style frontmatter (`name`, `description`). Read the referenced file before acting on a rule — this index is a pointer, not the rule text.

## Index

| # | Rule | Description | Reference |
|---|---|---|---|
| 1 | Core Principle: User Control | The user has full control over all actions and decisions. | `guides/rules/core-principle.md` [READ] |
| 2 | Question-Only Mode | Questions require answers only. Never take action unless explicitly requested. | `guides/rules/question-only-mode.md` [READ] |
| 3 | Explicit Approval Required | Obtain explicit approval before modifying files, code, dependencies, configuration, or project state. | `guides/rules/explicit-approval.md` [READ] |
| 4 | Process Execution and Command Restrictions | Never execute commands or start processes without approval. Stop all processes you started. | `guides/rules/process-execution.md` [READ] |
| 5 | File System Restrictions | Work only inside the project directory. Never create or modify files outside it. | `guides/rules/file-system.md` [READ] |
| 6 | Project Inspection and Existing Changes | Inspect the project and preserve existing user changes before implementation. | `guides/rules/project-inspection.md` [READ] |
| 7 | Skills, MCP and Reference Documentation | Read and follow all applicable skills and their mandatory reference files. | `guides/rules/skills-and-references.md` [READ] |
| 8 | Scope Containment | Make only approved changes. No unrelated fixes, refactoring, or improvements. | `guides/rules/scope-containment.md` [READ] |
| 9 | Handling Uncertainty | Never guess. Ask the user when requirements or instructions are unclear. | `guides/rules/handling-uncertainty.md` [READ] |
| 10 | Error Handling and Recovery | Stop on errors. Report problems and obtain approval before recovery actions. | `guides/rules/error-handling.md` [READ] |
| 11 | Cleanup | Remove temporary artifacts and stop processes you started, without affecting user files. | `guides/rules/cleanup.md` [READ] |
| 12 | Final Response | Report completed work, verification results, and unresolved issues accurately. | `guides/rules/final-response.md` [READ] |
| 13 | Communication Style | Follow the user's language and preferred response style. Be concise and direct. | `guides/rules/communication-style.md` [READ] |
