# counter_app

Flutter counter app with full UX design: increment, decrement, reset counter.

## Project Setup Notes
- The initial `.gitignore` was a Python template that included `lib/` — this line was removed so Flutter source in `lib/` is git-tracked.
- `flutter create --org com.example --project-name counter_app .` was used to generate the skeleton.
- Entry point: `lib/main.dart`
- Package: `com.example.counter_app`

## Code Structure
- `lib/main.dart` — `CounterApp` (MaterialApp root, no debug banner)
- `lib/screens/counter_screen.dart` — `CounterScreen` with full design implementation
- Tests use `CounterApp` (not the old `MyApp`)

## Design System (from designer_output.md + design/applied/*.html)
- Background: `#F0F4FF`
- AppBar: `#4F46E5`, white "🔢 Flutter Counter", centered, elevation 0
- Counter card: white, borderRadius 24, shadow rgba(79,70,229,0.18), top 4px gradient bar (#4F46E5→#818CF8)
  - Label "현재 카운트": 13px w600 #6B7280 letterSpacing 2
  - Value: 96px w700 #4F46E5
  - Hint: 11px #9CA3AF
- Decrement (−): 64×64, borderRadius 20, gradient #EF4444→#DC2626, red shadow
- Increment (+): 64×64, borderRadius 20, gradient #4F46E5→#4338CA, indigo shadow
- Button labels: 10px #9CA3AF below each button
- Reset: OutlinedButton, border #E5E7EB 1.5px, borderRadius 12, Icons.refresh, #6B7280

## Build Environment Notes (ARM64 system)
- System is ARM64 (aarch64); AGP 8.11.1 AAPT2 is x86-64 only
- Required fix: Install x86-64 libc6 and libgcc_s1 libraries from Ubuntu amd64 packages
  - `/lib64/ld-linux-x86-64.so.2` — from libc6_2.39-0ubuntu8_amd64.deb
  - `/usr/lib/x86_64-linux-gnu/{libdl.so.2,libpthread.so.0,libm.so.6,librt.so.1,libc.so.6}` — from same package
  - `/usr/lib/x86_64-linux-gnu/libgcc_s.so.1` — from libgcc-s1_14-20240412-0ubuntu1_amd64.deb
- After installing those, AAPT2 runs via the built-in x86 emulation layer ("rosetta")
- `flutter analyze` → no issues; `flutter build apk --debug` → succeeds
