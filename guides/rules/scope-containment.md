---
name: scope-containment
description: Implement only what was explicitly approved; no opportunistic fixes or refactoring.
---

**Implement only what was explicitly approved.**

- Do not fix unrelated bugs.
- Do not refactor neighboring components.
- Do not improve unrelated code.
- Do not modify shared or base classes unless explicitly authorized.
- Do not change public APIs unless included in the approved plan.
- Do not change architecture unless explicitly requested.
- Do not introduce abstractions without a concrete requirement.
- Do not add defensive code, fallbacks, or compatibility layers without justification and approval.
- Do not update unrelated documentation.
- Do not perform opportunistic cleanup.

### Base-class protection

Do not modify base classes, shared classes, or common infrastructure unless explicitly requested.

Prefer extending existing functionality through inheritance or service overrides when appropriate, without modifying protected base implementations.

### UX and UI protection

- Do not redesign interfaces without explicit approval.
- Do not change layouts, spacing, styling, or component structure outside the requested scope.
- Do not make UX improvements independently.
- Any layout compaction or substantial UX change requires a separate proposal and preview, followed by explicit approval.
