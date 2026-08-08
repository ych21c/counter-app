# Flutter Counter App — Agent Notes

## Project
Single-screen Flutter counter app. One screen, number starting at 0, one button to increment.

## Build Fix (Critical)
The container has ~7.8GB total RAM with ~3GB available at build time.
The original `android/gradle.properties` set `-Xmx8G -XX:MaxMetaspaceSize=4G` which exceeded available memory and caused the Gradle daemon to be OOM-killed.

**Fix applied:** Reduced JVM args in `android/gradle.properties`:
```
org.gradle.jvmargs=-Xmx2G -XX:MaxMetaspaceSize=512m -XX:ReservedCodeCacheSize=256m -XX:+HeapDumpOnOutOfMemoryError
```

## Stack
- Flutter 3.41.6, Dart 3.11.4
- AGP 8.11.1, Gradle 8.14, Kotlin 2.2.20
- All dependencies cached locally in ~/.gradle
