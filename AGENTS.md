# counter-app — Agent Notes

## Project
Flutter counter app: single screen, counter starting at 0, one button to increment.

## Key Files
- `lib/main.dart` — sole Dart source file; contains `CounterPage` (StatefulWidget)

## Pitfalls Found
- The original `.gitignore` was a Python template that included `lib/` — this caused the Flutter source directory to be git-ignored. It was replaced with a Flutter-appropriate `.gitignore`.
- The project had partial Android/iOS scaffolding but no `pubspec.yaml` or `lib/`. Running `flutter create .` (with `--project-name counter_app --org com.example`) regenerated the full project structure correctly.
