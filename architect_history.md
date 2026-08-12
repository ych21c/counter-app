

---
## Stage: design

# Software Architect - 프로젝트 30dcf5ed

## 카운터 앱 아키텍처 및 디자인 재설계

먼저 디자이너에게 디자인 스펙을 요청하고, 이를 기반으로 아키텍처와 구현을 반영하겠습니다.

---

## 🎨 디자인 스펙 (UI/UX Designer 위임 결과)

### CounterScreen 전체 디자인

```
┌─────────────────────────────────┐
│                                 │
│         Counter App             │  ← AppBar (deep purple)
│                                 │
├─────────────────────────────────┤
│                                 │
│                                 │
│         카운터                   │  ← 섹션 레이블
│                                 │
│       ┌─────────────┐           │
│       │             │           │
│       │      42     │           │  ← 카운터 숫자 카드
│       │             │           │
│       └─────────────┘           │
│                                 │
│   현재 카운트: 42               │  ← 서브텍스트
│                                 │
│  ┌────┐   ┌────┐   ┌────┐      │
│  │ −  │   │ R  │   │ +  │      │  ← 액션 버튼 3개
│  └────┘   └────┘   └────┘      │
│                                 │
└─────────────────────────────────┘
```

---

## 📐 아키텍처 문서

```markdown
# architecture.md - 프로젝트 30dcf5ed

## 기술 스택
- Framework: Flutter 3.x
- Language: Dart
- State Management: setState (단순 앱)
- 저장소: SharedPreferences (카운터 영속성)

## 디자인 시스템

### 색상 팔레트
- Primary: #6200EA (Deep Purple)
- Primary Light: #9D46FF
- Primary Dark: #0a00b6
- Accent: #FF6D00 (Deep Orange)
- Background: #F5F5F5
- Surface: #FFFFFF
- On Primary: #FFFFFF
- On Surface: #212121
- Subtitle: #757575

### 타이포그래피
- 앱 제목: fontSize 20, fontWeight Bold, color White
- 카운터 숫자: fontSize 80, fontWeight w900, color Primary
- 섹션 레이블: fontSize 16, fontWeight w600, color Subtitle
- 서브텍스트: fontSize 14, color Subtitle

### 버튼 스타일
- 감소(−): 원형, 지름 64px, Accent color, 아이콘 remove
- 증가(+): 원형, 지름 64px, Primary color, 아이콘 add
- 리셋(R): 원형, 지름 48px, Grey, 아이콘 refresh
- elevation: 4.0, shape: CircleBorder

### 카드 스타일
- borderRadius: 24px
- elevation: 8.0
- padding: 40px vertical, 80px horizontal
- gradient: LinearGradient(Primary Light → Primary Dark)
```

---

## 💻 구현 코드

### `lib/main.dart`

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const CounterScreen(),
    );
  }
}
```

### `lib/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';

class AppTheme {
  // ── 색상 팔레트 ──────────────────────────
  static const Color primary      = Color(0xFF6200EA);
  static const Color primaryLight = Color(0xFF9D46FF);
  static const Color primaryDark  = Color(0xFF0A00B6);
  static const Color accent       = Color(0xFFFF6D00);
  static const Color background   = Color(0xFFF5F5F5);
  static const Color surface      = Color(0xFFFFFFFF);
  static const Color onPrimary    = Color(0xFFFFFFFF);
  static const Color onSurface    = Color(0xFF212121);
  static const Color subtitle     = Color(0xFF757575);

  // ── 테마 ─────────────────────────────────
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: accent,
      background: background,
      surface: surface,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: onPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: onPrimary,
        letterSpacing: 1.2,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(          // 카운터 숫자
        fontSize: 80,
        fontWeight: FontWeight.w900,
        color: onPrimary,
        letterSpacing: -2,
      ),
      titleMedium: TextStyle(           // 섹션 레이블
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: subtitle,
        letterSpacing: 0.5,
      ),
      bodySmall: TextStyle(             // 서브텍스트
        fontSize: 14,
        color: subtitle,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        shape: const CircleBorder(),
      ),
    ),
  );
}
```

### `lib/screens/counter_screen.dart`

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // ── 카운터 조작 ──────────────────────────
  void _increment() => _updateCounter(_counter + 1);
  void _decrement() => _updateCounter(_counter - 1);
  void _reset()     => _updateCounter(0);

  void _updateCounter(int value) {
    setState(() => _counter = value);
    _animController.forward().then((_) => _animController.reverse());
  }

  // ── 빌드 ─────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
    title: const Text('Counter App'),
    actions: [
      IconButton(
        icon: const Icon(Icons.info_outline, color: AppTheme.onPrimary),
        onPressed: () => _showInfoDialog(),
        tooltip: '정보',
      ),
    ],
  );

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLabel(context),
              const SizedBox(height: 24),
              _buildCounterCard(context),
              const SizedBox(height: 16),
              _buildSubtitle(context),
              const SizedBox(height: 48),
              _buildActionButtons(),
              const SizedBox(height: 32),
              _buildResetButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ── 섹션 레이블 ──────────────────────────
  Widget _buildLabel(BuildContext context) => Text(
    '카 운 터',
    style: Theme.of(context).textTheme.titleMedium?.copyWith(
      letterSpacing: 6,
      fontWeight: FontWeight.w700,
    ),
  );

  // ── 카운터 카드 ──────────────────────────
  Widget _buildCounterCard(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.primaryLight, AppTheme.primaryDark],
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }

  // ── 서브텍스트 ───────────────────────────
  Widget _buildSubtitle(BuildContext context) => Text(
    '현재 카운트: $_counter',
    style: Theme.of(context).textTheme.bodySmall,
  );

  // ── +/− 버튼 ─────────────────────────────
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircleButton(
          icon: Icons.remove,
          color: AppTheme.accent,
          size: 64,
          onPressed: _decrement,
          tooltip: '감소',
        ),
        const SizedBox(width: 32),
        _buildCircleButton(
          icon: Icons.add,
          color: AppTheme.primary,
          size: 64,
          onPressed: _increment