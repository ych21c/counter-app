# counter_app

Flutter counter app: single screen, counter starts at 0, centered on screen, one button increments by 1.

## Project Setup Notes
- The initial `.gitignore` was a Python template that included `lib/` — this line was removed so Flutter source in `lib/` is git-tracked.
- `flutter create --org com.example --project-name counter_app .` was used to generate the skeleton.
- Entry point: `lib/main.dart`
- Package: `com.example.counter_app`

## Build Notes
- AGP 8.11.1 / Gradle 8.14 stack (settings.gradle.kts). The `AAPT2 Daemon startup failed` error seen in an earlier CI run was transient (AAPT2 binary not yet cached); once the Gradle/AAPT2 caches are warm the build completes cleanly.
- Verified with `flutter clean && flutter build apk --debug` → success.
