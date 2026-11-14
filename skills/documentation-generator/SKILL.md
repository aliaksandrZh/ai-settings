---
name: documentation-generator
description: Generate step-by-step integration/setup guides reconstructed from an existing codebase, where every step, command, code sample, and config value is copied from the actual source and verified against it — never invented or idealized. Use whenever the user asks how to add a feature to their existing project "the way this repo does it", asks for a guide, tutorial, walkthrough, setup doc, or "how would I do this from scratch" based on code in the repo; when they say "document what we did", "write a guide for this setup", or ask for plain wiring instructions for a feature already implemented in the project. Also triggers for "step-by-step", "from scratch", "how to reproduce", "integrate", "add X to my app", or "setup documentation" whenever an existing implementation is the source material.
---

# Documentation generator — integration guides rebuilt from source

## The extraction principle (read this twice)

The guide is a **standalone artifact** the reader will copy into their own project, share with a teammate, or read months later. None of the source project's archaeology belongs in it: not commit IDs, not "v1/v2 of this repo", not file:line citations, not "adapted from…" notes, not *(expected — the readme said so…)* markers, and not a Sources appendix. The reader asked *how to do the thing*; where each fact was learned from is your business in the writing process, not their business on the page. Verification still happens — that is what keeps the guide truthful — but its conclusions ship in your message to the user, never inside the guide.

Corollary — **scope statements are positive-only.** State what the guide includes ("Keycloak in Docker, JWT-protected API, Angular login with silent refresh — standard framework ingredients only"). Do not name what is excluded. Naming excluded libraries or layers — even in a "no X" sentence — is a violation: the reader said *nothing custom*, and a paragraph inventorying what exists elsewhere in the repo is re-litigating the request. If the resolved scope conflicts with what exists in the repo in a way the reader must know, say the fact, never the artifact's name.

## Three laws

**1. The repository is the only source of truth — but it is the evidence, not the blueprint.**

LLMs write *plausible* guides. The plausible guide names ports, env vars, secrets, package flags, and config keys that *typically* appear in tutorials — and a reader reproducing it gets silent failures. So: **every fact in the guide must be visible somewhere in this repository.** A *fact* is anything a reader relies on: a file path, a dependency and version, a port, an issuer URL, a client ID, an option name, a command flag. If you can't point at the file it came from, it doesn't go in. What you "know" about how this stack is "usually" set up is not evidence — it is exactly the idealized guide this skill must not write.

Cut both ways: if the repo contains a real dev secret, a pinned version, or a hard-coded port, use it. A reproduction guide needs the values the implementation actually runs with — not `<your-client-secret>` placeholders that reproduce nothing. Carry dev-only caveats (as stated in the source) next to the value.

**2. The guide serves the reader's goal, not the repo's biography.**

The reader is a developer with their *own* project — usually wanting to add this feature to it. Write to that developer. The source project exists to extract exact code, values, and ordering evidence from; it is not the subject of the guide. Recreation-file-by-file tours of the demo repo ("here is the entire realm JSON, line 1–157") belong only when the user explicitly asked to rebuild that exact artifact.

**3. Every written line must earn its place.**

Pointless text is guide-poison: a reader skimming for the next action buries the real signal in it. A sentence belongs in the guide only if it (a) tells the reader an action, (b) states a verified fact or warning they would otherwise trip over, or (c) gives the one-sentence ordering criterion for the step. Everything else — motivational preamble, restating what the intro already said, commentary about the guide itself, architecture essays, paragraphs explaining what a code block visibly shows — does not survive the draft. Concretely:

- **Code over prose.** A config block needs no sentence explaining its keys if the keys are self-evident; comment inside the block instead when a key is non-obvious.
- **One sentence of "why here" per step** — not a paragraph.
- **No repetition.** A value appears once; later steps reference it by name ("the issuer from step 1").
- **No guide-about-the-guide.** "This section covers...", "As we saw earlier..." — delete.

If the same fact can be said in half the words, say it in half the words.

## Step 0: Resolve scope — before reading anything in depth

Most guide failures are scope failures. Answer these three questions first, in one sentence each:

1. **Which era/layer?** The repo may have grown packaging layers over its history (demo code → extracted libraries → template packs). If the user says "v1", names an era, or describes the *plain* setup, restrict to that layer — use `git log --oneline` and `git show --stat` to find the commit range that implements what was asked, and document that. Later packaging layers (custom NuGet/npm packages, scaffolding tools, test projects) are OUT of scope unless requested. The strongest tell: if the user's request can be satisfied by what the framework provides, a repo-custom package around it is a different topic — don't sneak it in.
2. **Integration or recreation?** "How do I add X to my app", "I have an existing project", "recreate/integrate" → recipe mode (the default). Only an explicit "rebuild this repo from scratch" justifies a file-by-file reconstruction.
3. **What stays out?** List, mentally, what the request does not cover (infra setup? the other client topology? styling? tests?) — and only include what's genuinely needed to make the feature work, marked as context.

If two readings are plausible and they lead to different guides, ask the user one focused question. Otherwise state the resolved scope in the guide's opening — positively, in one sentence ("This guide wires Keycloak login into an existing Angular app using standard framework ingredients only"), never as a list of exclusions, and never citing where the content came from.

6. **Do not clone the source project's identity into the reader's guide.** The demo's folder names (`Azh.Api`, `Azh.UI`), seeded users (`alice`/`bob`/`m2m`), sample claim names (`preferred_username`, `IProfile`), and demo-specific conventions are *illustrations*, not rules. Treat them as such:
   - Project identifiers become "rename to yours" (or "use whatever your structure calls it") in prose — never appear unchanged in commands/scripts a reader would run literally.
   - Protocol-standard names (an OIDC claim like `preferred_username`, scope names, role names from a realm, an audience/client id) are *stated as standards* with the explicit note that the reader renames them to fit their token/realm and project.
   - Demo seed users get an uppercase caveat in the realm section: they are throwaway dev values, replace/remove before any shared environment.

## Step 1: Inventory + sequence (evidence first, before writing anything)

1. **Confirm it exists** in the scope you just resolved. If a part of the requested feature isn't in the repo, don't scaffold or invent it — tell the user what's missing and ask whether to cover what exists.
2. **Files & dependencies** — which files the feature touches within scope, grouped by what they contribute; read `*.csproj`, `package.json`, `docker-compose.yml` for real versions and packages.
3. **Implementation order** — from git history (which commit introduced what) and dependency direction (a thing must exist before its consumer reads it). Every ordering decision needs a one-sentence criterion. If ordering "feels natural" instead of traced, that's invention.
4. **Mandatory vs optional** — a step is MANDATORY if a trace proves later steps break without it (a file that is read, a port that is hard-coded, a package that is referenced). OPTIONAL steps work without being taken; state why they're skippable. Label only what you can trace.

## Step 2: Draft as a recipe

Read `references/guide-template.md` and follow its structure. Rules:

- **Steps are actions on the reader's project**: *install* (package X), *create* (file Y with this content), *modify* (your `Program.cs` / `app.config.ts` — show the added lines, then the surrounding context so the reader can locate the insertion point in their analogous file), *run*, *verify*. Full verbatim copies only for files that would be genuinely new in the reader's project.
- **"Before you start" section names the checkpoints in the reader's own project structure** — the things they should locate/confirm in *their* codebase before step 1 ("your app.config providers array", "your Program.cs builder line", "the origin you serve the SPA from"). This is the reader's map for translating repo-shaped steps to their shape.
- **No source-project identifiers, idioms, or conventions leak in.** The demo's project names, seeded users, claim names (`preferred_username`, etc.), demo CSS classes, folder layout, and scaffold-style commands (`ng new ...`) are not commands the reader runs verbatim; they are presented as illustrations with explicit rename-to-yours guidance, and are called out as dev-only where relevant.
- **No provenance anywhere in the guide** (see the extraction principle): commit IDs, "v1/v2", "adapted", file:line citations, Sources sections, markers pointing at the repo's own docs or walkthroughs. A caveat is stated as the fact's content, not as a citation ("the realm imports only on first boot — changing the file needs a reset", not "per the compose comment, ...").
- **Code that used to live in a package is presented as plain code.** If, within the requested scope, a snippet came from a library that the user excluded, inline it directly with no mention of where v-something kept it. The reader should not be able to tell that any archaeology happened.
- **Expected outputs must be earned** — traceable to code, or stated in the repo's docs; anything derived is marked plainly *(expected)*, with no pointer to source material.
- **Gotchas are repo-evidenced only.** None found → write exactly "None verified against the source."

## Step 3: Verification pass — as an adversary

Re-read the finished draft assuming you hallucinated. Item by item:

- Every file path in the Sources appendix exists; every cited line range says what the claim needs.
- Every command's flags/paths/arguments match real files/scripts.
- Every config value (ports, URLs, IDs, versions, secrets) matches the source exactly.
- Every code sample matches its source file (adaptations are fine on the page, but never labeled as adaptations there — they read as normal code).
- Every sequence claim has its criterion; every MANDATORY label has its trace.
- **Scope discipline**: no artifact from an out-of-scope layer leaked in (re-check every package, import, and file mentioned — is it part of what the user asked for?), and **no provenance** (re-check: no commit IDs, no "v1/v2", no "adapted", no citation-style remarks anywhere in the guide — a grep for the relevant commit ids and package names returns zero).

Report results — in your message to the user, never in the guide — as findings grouped by severity: **HIGH** = source contradicts a step, invented values, failing commands → fix before delivering, say what was fixed; **MEDIUM** = claims you could not verify → fix by verifying or soften the claim (do not sprinkle *[unverified]* markers into the reader's guide; the caveat goes in your findings report instead); **LOW** = structure/wording.

## In vs. out of the guide

| In | Out |
|---|---|
| Steps traceable to real files, commands, configs during *writing* | The traceability itself, once it would appear on the page |
| The actual versions, pinned tags, real dev values | "latest" or versions from memory |
| The reader's translation map ("your app.config's providers array") | A biography of the demo repo's file tree |
| Code as the delta to the reader's analogous file | Whole-file verbatim dumps of reader-uninteresting files |
| Gotchas the evidence shows, stated as facts | Hypothetical failure modes; gotchas attributed to their source |
| Packaging layers/custom libraries, only if requested — and then as normal content, never as contrast | Scope preambles naming excluded packages, commits, or repo layers |
| Project identifiers presented as rename-to-yours, with protocol-standard caveats | Hard-coded demo folder names, demo-seeded users, demo claim names presented as universal rules |
