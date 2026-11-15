---
name: azh-dotnet
description: Use when you work with .net to follow user preferences. Project structure, architectural boundaries. 
---

## Project structure
- Preserve the established solution structure and directory nesting. Create directories and projects only when required by actual implementation; never create empty directories or `.gitkeep` files; avoid arbitrary catch-all directories such as `Utils`, `Misc`, or `Managers`. Read [project-structure.md](references/project-structure.md) before creating, moving, or reorganizing projects, directories, or files.

## Architecture
- Follow Clean Architecture boundaries — Domain has no dependencies, Application depends on Domain, Infrastructure depends on Application and Domain, hosts compose everything. Keep code in the project that owns its responsibility; each project registers its own services. Read [architecture-boundaries.md](references/architecture-boundaries.md) when deciding where code belongs or how projects may reference each other.

## Authentication
- Auth is a reusable module free of HTTP dependencies (`HttpContext`, middleware, cookies, CORS). HTTP-specific authentication (JWT Bearer, cookies, claims) stays in the host. Read [authentication-module.md](references/authentication-module.md) when working on authentication, tokens, or Identity.

## Personal Preferences

- Follow established project conventions instead of introducing alternative patterns.
- Avoid unnecessary abstractions, interfaces, wrappers, helpers, and inheritance.
- Do not overengineer straightforward functionality.
- Do not implement speculative functionality or prepare infrastructure for hypothetical requirements.
- Do not refactor unrelated code.
- Do not rename or move existing files without necessity.
- Preserve existing formatting when modifying code.
- Change only what is required by the task.
- Prefer complete updated code over isolated snippets for non-trivial modifications.
- Do not introduce architectural changes without explaining their impact and obtaining approval when required.

## Skills, MCPs, and Ambiguity

- Always check available skills and MCPs and invoke relevant ones.
- Use Microsoft .NET skills for general .NET development, framework practices, EF Core, and testing.
- Use this skill for project structure, architectural boundaries, and personal preferences.
- Do not duplicate general .NET guidance already covered by specialized skills.
- Inspect existing code and conventions before deciding where new code belongs.
- If a requirement conflicts with an explicit project decision or user preference, ask which takes priority.
- If the correct placement or ownership remains unclear, ask instead of inventing a convention.

**Core principle:** Implement the requested functionality within the established architecture. Preserve project boundaries and avoid unnecessary redesign or reorganization.
