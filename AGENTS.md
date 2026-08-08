# Project: counter_app

Flutter counter app — single screen, counter starts at 0, increments by 1 on button press.

## Key Facts
- Flutter 3.41.6 / Dart 3.11.4
- Project name: `counter_app` (set via `flutter create --project-name counter_app`)
- Entry point: `lib/main.dart`

## Build Commands
```
flutter analyze          # static analysis
flutter build apk --debug   # produces build/app/outputs/flutter-apk/app-debug.apk
```

## History
- Initial commit had `lib/main.dart` but no `pubspec.yaml` (invalid Flutter project).
- Fixed by running `flutter create --project-name counter_app --overwrite .`, then restoring original `main.dart`.
- AAPT2 daemon startup failure (`aapt2-8.11.1-12782657-linux Daemon #0: Daemon startup failed`) was caused by a corrupted Gradle transform cache at `~/.gradle/caches/8.14/transforms/`. Resolved by running `flutter clean` to purge build artifacts, then rebuilding — this triggers a fresh AAPT2 transform and fixes the daemon error.
