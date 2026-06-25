# AGENTS.md

Guidance for agents working on this Flutter Dive Log learning project.

## Project Context

This is a learning project. Keep code simple, direct, and easy to explain.
When making changes, describe what changed, why it changed, and how it fits into
the existing app structure.

The app currently uses:

- Flutter for the UI.
- Drift for typed database access.
- SQLite for local persistence.
- build_runner for generated Drift code.

## Change Rules

- Make small, focused changes only.
- Before editing files, summarize the plan and list every file that will change.
- Do not commit changes unless explicitly asked.
- Do not run destructive commands.
- Do not revert user changes unless explicitly asked.
- Preserve the existing CRUD behavior:
  - Add Dive
  - View Dives
  - View Details
  - Edit Dive
  - Delete Dive
  - Dashboard

## Code Style

- Prefer straightforward Flutter widgets and local patterns already used in the
  project.
- Avoid introducing state management libraries or large abstractions unless the
  user asks for them or the existing code clearly needs them.
- Use clear comments in replacement files explaining each major section.
- Include short "future change" notes where they help a learner understand where
  later improvements would go.
- Keep comments useful and specific. Avoid comments that simply repeat the code.

## Database Rules

Any database schema change must include:

- The exact table or column changes.
- A schema version update.
- A Drift migration plan.
- An explanation of how existing user data will be preserved.
- Any required updates to Add, Edit, Detail, List, or Dashboard screens.

Do not make schema changes casually. Treat them as higher-risk than ordinary UI
changes.

## Verification

After code changes, run:

```powershell
dart format .
flutter analyze
```

For database model changes, also consider whether generated Drift code needs to
be updated with build_runner:

```powershell
dart run build_runner build
```

Only run build_runner when generated database code actually needs to change.

## Scope

For documentation-only changes, do not modify Dart files and do not run Flutter
format/analyze unless the user asks.
