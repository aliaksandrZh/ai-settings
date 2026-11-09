---
name: skills-and-references
description: Discover and read all applicable skills, MCP resources, and referenced documentation in full before planning or implementing.
---

# Skills and References

## Skills

Skills are mandatory when their descriptions match the task.

Whenever starting a task that involves planning, reviewing, implementing, or delegating:

1. Review the available skills.
2. Identify all relevant skills.
3. Read the complete instructions for every applicable skill.
4. Inspect every referenced documentation file required by those skills.
5. Do not treat an inline skill description as a complete specification.
6. If multiple skills apply, follow all of them.

## Reference Files

Instructions such as `Read [reference-file.md]` are mandatory.

Before producing a plan or implementation:

- Find all referenced documentation.
- Open and read the referenced files.
- Verify that all required references have been inspected.
- Do not proceed with incomplete skill instructions.

If a required reference is unavailable, STOP and inform the user.

## MCP Discovery

- Inspect available MCP servers and their exposed tools when relevant to the task.
- Check whether MCP servers provide relevant skills, documentation, project resources, or specialized tools.
- Prefer relevant, authoritative, and up-to-date resources provided by MCP servers.
- Read the descriptions and usage instructions of relevant MCP tools before using them.
- Do not assume previously discovered MCP capabilities are still available or unchanged.
- Do not install or configure additional MCP servers without explicit approval.

## Tool Selection

- Prefer dedicated tools designed for the requested operation.
- Use built-in `Read`, `Write`, and `Edit` tools for file operations.
- Never use Python, Perl, Bash, shell commands, or custom scripts to read or modify files when dedicated file tools are available.
- If a built-in file tool fails, read and investigate the complete error. If the problem cannot be resolved using the available tools, STOP and ask for permission before using alternative methods.
- Use Playwright MCP for browser interaction and automation whenever available.
- Do not install additional tools, libraries, or browser automation dependencies without explicit approval.

## Skill Conflicts

If project instructions, skills, MCP instructions, and user requirements conflict:

- Identify the exact conflict.
- STOP and ask the user which source of truth to follow.
- Do not silently choose an interpretation or proceed until clarified.

Always mention relevant skills and references in implementation plans and task breakdowns.

If delegating work, explicitly require subagents to follow the applicable skills, MCP instructions, and project rules.