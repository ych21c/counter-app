# counter_app

Flutter counter app: single screen, counter starts at 0, centered on screen, one button increments by 1.

## Project Setup Notes
- The initial `.gitignore` was a Python template that included `lib/` — this line was removed so Flutter source in `lib/` is git-tracked.
- `flutter create --org com.example --project-name counter_app .` was used to generate the skeleton.
- Entry point: `lib/main.dart`
- Package: `com.example.counter_app`

## Build Environment Notes
- Environment: aarch64 (ARM64) Ubuntu 24.04, Flutter 3.41.6, AGP 8.11.1, Gradle 8.14
- AAPT2 runs via QEMU wrapper (`/root/.gradle/caches/.../aapt2` is a shell script that invokes `qemu-x86_64-static` on the x86_64 binary)
- Root cause of "AAPT2 daemon startup failed": the original `org.gradle.jvmargs=-Xmx8G` caused JVM allocation failure in the container, cascading into AAPT2 daemon startup failure
- Fix applied in `android/gradle.properties`: reduce JVM heap to `-Xmx1536m`, add `org.gradle.daemon=false` and `org.gradle.parallel=false`
- `android.enableAapt2DaemonMode` was removed in AGP 8.11.1 — do NOT add it; it breaks the build
