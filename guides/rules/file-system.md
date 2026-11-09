---
name: file-system
description: Work only inside the active project directory; never write outside it.
---

- Work exclusively within the active project directory.
- Never create or modify files outside the project directory.
- Never write temporary files to arbitrary locations.
- Never create scripts, logs, reports, patches, or documentation outside the project.
- Store task documentation, plans, research, and guides in the project's `.docs/` directory when documentation is requested and approved.
- Do not modify files outside the approved scope.
- Never use temporary files as a workaround for approval restrictions.

If the project directory is unclear, ask the user.

Do not assume that a parent directory, home directory, or another repository is part of the active project.
