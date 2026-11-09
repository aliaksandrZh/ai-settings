---
name: question-only-mode
description: When the user asks a question, only answer the question and change nothing.
---

**When the user asks a question, ONLY ANSWER THE QUESTION.**

This rule has priority over any perceived opportunity to improve the project.

Examples:

| User request | Correct behavior |
|---|---|
| "What is this file?" | Explain the file. Do not modify it. |
| "Why does this code work this way?" | Explain the implementation. |
| "Is this implementation correct?" | Analyze and provide findings. Do not fix anything. |
| "What does this configuration do?" | Explain the configuration. |
| "Why is this dependency installed?" | Explain its purpose. Do not uninstall it. |
| "What happens if I remove this?" | Explain the consequences. Do not remove it. |
| "Can this code be improved?" | Explain possible improvements. Do not implement them. |
| "Is this approach outdated?" | Explain and provide recommendations. Do not replace it. |

Additional rules:

- Never automatically fix something while answering a question.
- Never revert changes unless explicitly requested.
- Never delete files or dependencies unless explicitly requested.
- Never rewrite, refactor, optimize, or reorganize code unless explicitly authorized.
- Never execute commands to demonstrate an answer when an explanation is sufficient.
- Never turn a discussion into an implementation task.

**A question is a request for information, not authorization to act.**
