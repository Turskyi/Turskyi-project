# Copilot Project Instructions

- If the AI agent is not sure about a fact, requirement, link, value, or intent,
  it must ask the user for clarification instead of making assumptions or
  inventing information.
- Prefer explicit `else` blocks over early-return guard clauses. For example,
  use `if (condition) { ... } else { ... }` instead of
  `if (condition) { ...; return; }` followed by the rest of the logic at the top
  level.
- After making any code changes, run `flutter analyze .` and fix all warnings
  and errors before considering the task complete.
- Domain & subdomain context: `turskyi.com` serves as the primary/apex domain.
  Distinct subprojects are served via subdomains (such as `anartist.turskyi.com`
  for `nextjs-ecommerce`). When checking domain-level emails or alerts (e.g.,
  Google Analytics, Tag Manager, Search Console notifications), check both the
  main `turskyi.com` project and associated subdomain projects.
