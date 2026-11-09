---
name: process-execution
description: Never launch a process without explicit user approval.
---

**Never launch a process without explicit user approval.**

This includes:

- Development servers.
- Build processes.
- Test runners.
- Linters and formatters.
- Database migrations.
- Docker containers.
- Background jobs.
- Scripts and automation.
- Package manager commands.
- Generators and scaffolding tools.
- Any other executable command that starts a process.

Before launching a process:

1. Explain why it is needed.
2. Specify the exact command.
3. Explain its expected effects.
4. Request approval.
5. Wait for explicit approval.

