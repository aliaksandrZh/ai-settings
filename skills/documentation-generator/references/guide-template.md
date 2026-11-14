# Guide template

Output format for guides from the documentation-generator skill. The guide is a **standalone artifact** the reader copies into their own project and shares — it must give no sign that it was reconstructed from anywhere. The source repo is the evidence for writing it; the evidence itself never appears in it. Keep it lean — every line must earn its place.

Conventions:

- Single self-contained markdown file.
- `(only if)` sections may be dropped when they have no content; never leave an empty section.
- **No provenance**: no commit IDs/SHAs, no "v1/v2 of the repo", no file:line citations, no "adapted from…", no *(expected — per <source>)* markers, no Sources/audit appendix. Caveats are stated as facts ("a config change to the realm needs a reset"), never attributed.
- Scope statements are **positive-only**: what the guide does; never a list of excluded items, package names, or repo layers.
- Steps written as actions on the reader's project: install / create / modify / run / verify.

Template:

```markdown
# <Action> in <reader's context> — step-by-step guide

> One paragraph, two–three sentences: what the reader ends up with, and the
> scope of the guide in positive terms (what it includes: which pieces, which
> standard ingredients). No mention of exclusions or origins.

## Before you start — checkpoints in YOUR project

The reader's own integration points, as a short list. For each: what to
locate/confirm in their project structure — rename-to-yours for any identifier repeated from the source — (e.g. "your Angular providers array
in `app.config.ts`", "your `Program.cs` `builder.Services` section — auth
registration goes there", "the origin the app is served from — Keycloak needs
it registered"). Plus the actual prerequisites with their pinned versions.

## Steps

Numbered steps, each heading ending in its label: `— MANDATORY` or
`— OPTIONAL`.

### 1. <action> — MANDATORY

Why here: <one sentence — a dependency fact ("the client must exist in the
realm before login can redirect there"), not a history fact>

Install:
```bash
<the command>
```

Add to your <analogous file>:
```ts
<added lines, then minimal surrounding context so the insertion point is
locatable in the reader's analogous file>
```

Create <new file only if it is genuinely new in the reader's project>:

```ts
<full content>
```

Expected: <quoted state or *(expected)*>

## Run and verify

A short manual sequence: do X → observe Y, with observations either
deterministic consequences of the code shown or marked *(expected)*. This is
the guide's acceptance test.

## Gotchas

Verified traps only (value changes that require a reset, required exclude
flags, ordering traps), stated as facts. None verified → write exactly
"None verified against the source."
A trap that names identifiers the reader renames (a claim name, a role name, seed users) explains which standard it comes from and explicitly allows renaming.
```

If code was, inside the source project, organized in a package the reader's
request excludes, present it as plain code in the reader's project — no
mention of that organization anywhere ("create `X.cs`", not "inline the class
that v-something kept in its library").
