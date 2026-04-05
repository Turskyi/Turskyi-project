# Copilot Project Instructions

- If the AI agent is not sure about a fact, requirement, link, value, or intent, it must ask the user for clarification instead of making assumptions or inventing information.
- Prefer explicit `else` blocks over early-return guard clauses. For example, use `if (condition) { ... } else { ... }` instead of `if (condition) { ...; return; }` followed by the rest of the logic at the top level.
- After making any code changes, run `flutter analyze .` and fix all warnings and errors before considering the task complete.
