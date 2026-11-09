---
name: explicit-approval
description: Require explicit user approval before making any project, file, dependency, configuration, Git, or environment changes. Always prepare a plan and wait for approval before implementation.
---

# Explicit Approval Required

**Never modify the project or its environment without explicit user approval.**

This applies to all actions, including:

- **Code and files:** creating, editing, deleting, renaming, moving, formatting, refactoring, or restructuring.
- **Dependencies and tools:** installing, updating, downgrading, or removing libraries, packages, plugins, and tools.
- **Configuration:** changing application settings, environment variables, build configuration, IDE settings, or Claude Code settings, permissions, hooks, and MCP configuration.
- **Git:** commits, rebases, merges, resets, reverts, stashes, branch deletion, push, pull, and Git configuration changes.
- **Processes:** launching commands, builds, tests, scripts, development servers, containers, migrations, or background processes.

Reading files, inspecting code, analyzing the project, and reading Git status, history, and diffs are allowed when relevant to the request.

## Approval Workflow

Before implementing any change:

1. Understand the request and inspect relevant project files.
2. Review applicable skills and read all mandatory reference files.
3. Clarify ambiguities with the user.
4. Prepare a concise implementation plan.
5. List every file that will be created, modified, or deleted.
6. Mention relevant skills and reference documentation.
7. Specify required dependencies, configuration changes, and commands/processes.
8. Present the plan and wait for explicit approval.

Never start implementation before approval.

Accepted approval tokens:
- `proceed`
- `yes`
- `1`
- `do it`
- `go`

## Approval Rules

- Approval applies ONLY to the immediately preceding, explicitly presented plan.
- Approval covers only the listed files, actions, and commands.
- Any additional files, dependencies, configuration changes, or scope expansion require separate approval.
- If unexpected changes become necessary, STOP and request approval.
- General statements such as "looks good", "interesting", or "that makes sense" are not approval.
- If interrupted, request approval again before resuming implementation.
- Never assume an action is authorized because it is technically necessary, convenient, or considered best practice.

## Before Every Patch

State:

`File: <path> | Reason: <reason> | Affected components: <components>`

If approval has not been granted, do not modify anything.

## Process Lifecycle

- Track all processes started by you.
- Stop all processes you started when the task ends or is interrupted.
- If a process fails or becomes stuck, stop it and report the problem.
- Never leave background processes running.
- Never terminate processes started by the user or other applications without permission.

The only exception is when the user explicitly asks you to start and keep a particular process running.

**When in doubt, STOP AND ASK.**
