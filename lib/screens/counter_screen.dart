import 'package:flutter/material.dart';

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

  // Design tokens from wireframe
  static const Color _primary = Color(0xFF4F46E5);
  static const Color _primaryDark = Color(0xFF4338CA);
  static const Color _primaryLight = Color(0xFF818CF8);
  static const Color _danger = Color(0xFFEF4444);
  static const Color _dangerDark = Color(0xFFDC2626);
  static const Color _background = Color(0xFFF0F4FF);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _textHint = Color(0xFF9CA3AF);
  static const Color _border = Color(0xFFE5E7EB);

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _increment() => _update(_counter + 1);
  void _decrement() => _update(_counter - 1);
  void _reset() => _update(0);

  void _update(int value) {
    setState(() => _counter = value);
    _animController.forward().then((_) => _animController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('🔢 Flutter Counter'),
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.3,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCounterCard(),
                const SizedBox(height: 32),
                _buildButtonRow(),
                const SizedBox(height: 24),
                _buildResetButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCounterCard() {
    return ScaleTransition(
      scale: _scaleAnim,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _primary.withAlpha(46), // 0.18 opacity ≈ 46/255
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withAlpha(15), // 0.06 opacity ≈ 15/255
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            children: [
              // Top 4px gradient accent bar (from #4F46E5 to #818CF8)
              Container(
                height: 4,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_primary, _primaryLight],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 40, 32, 40),
                child: Column(
                  children: [
                    const Text(
                      '현재 카운트',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _textSecondary,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_counter',
                      style: const TextStyle(
                        fontSize: 96,
                        fontWeight: FontWeight.w700,
                        color: _primary,
                        height: 1.0,
                        letterSpacing: -4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '버튼을 눌러 카운트를 변경하세요',
                      style: TextStyle(
                        fontSize: 11,
                        color: _textHint,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFab(
          label: '감소',
          icon: Icons.remove,
          colors: [_danger, _dangerDark],
          shadowColor: _danger,
          onPressed: _decrement,
        ),
        const SizedBox(width: 24),
        _buildFab(
          label: '증가',
          icon: Icons.add,
          colors: [_primary, _primaryDark],
          shadowColor: _primary,
          onPressed: _increment,
        ),
      ],
    );
  }

  Widget _buildFab({
    required String label,
    required IconData icon,
    required List<Color> colors,
    required Color shadowColor,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withAlpha(102), // 0.4 opacity
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: _textHint,
          ),
        ),
      ],
    );
  }

  Widget _buildResetButton() {
    return OutlinedButton.icon(
      onPressed: _reset,
      icon: const Icon(Icons.refresh, size: 16),
      label: const Text('초기화'),
      style: OutlinedButton.styleFrom(
        foregroundColor: _textSecondary,
        side: const BorderSide(color: _border, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        textStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
