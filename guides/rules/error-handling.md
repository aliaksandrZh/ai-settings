---
name: error-handling
description: On failure, stop, report the cause and impact, and never auto-correct.
---

When something goes wrong:

- Stop and identify the cause.
- Explain what happened.
- Report which files or components were affected.
- Report whether any process remains running.
- Propose recovery options.
- Wait for approval before reverting, deleting, repairing, or otherwise changing anything.
- **Never automatically undo your work.**
- A failed command or implementation does not grant permission to perform additional corrective actions.
- Never hide errors or claim success when an operation has failed.
