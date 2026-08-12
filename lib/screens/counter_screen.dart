import 'package:flutter/material.dart';

class _HistoryEntry {
  final String action;
  final int result;
  const _HistoryEntry({required this.action, required this.result});
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  final List<_HistoryEntry> _history = [];
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  // Design tokens from wireframe
  static const Color _primary = Color(0xFF4F46E5);
  static const Color _primaryLight = Color(0xFF818CF8);
  static const Color _danger = Color(0xFFEF4444);
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

  void _increment() => _recordAndUpdate(_counter + 1, '+1');
  void _decrement() => _recordAndUpdate(_counter - 1, '−1');

  void _reset() {
    setState(() {
      _counter = 0;
      _history.clear();
    });
    _animController.forward().then((_) => _animController.reverse());
  }

  void _recordAndUpdate(int value, String action) {
    setState(() {
      _counter = value;
      _history.add(_HistoryEntry(action: action, result: value));
    });
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
                if (_history.isNotEmpty) ...[
                  _buildActionLog(),
                  const SizedBox(height: 24),
                ],
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
      child: Card(
        color: Colors.white,
        elevation: 8,
        shadowColor: _primary.withAlpha(46),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Top 4px gradient accent bar
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
    );
  }

  Widget _buildActionLog() {
    // Show at most the 5 most recent entries, matching the wireframe's log panel.
    final entries = _history.length <= 5
        ? _history
        : _history.sublist(_history.length - 5);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '액션 로그',
            style: TextStyle(
              fontSize: 10,
              color: _textHint,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 6),
          ...entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.action,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF374151),
                    ),
                  ),
                  Text(
                    '→ ${entry.result}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: _primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
          backgroundColor: _danger,
          onPressed: _decrement,
        ),
        const SizedBox(width: 24),
        _buildFab(
          label: '증가',
          icon: Icons.add,
          backgroundColor: _primary,
          onPressed: _increment,
        ),
      ],
    );
  }

  Widget _buildFab({
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(64, 64),
            maximumSize: const Size(64, 64),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
          ),
          child: Icon(icon, size: 28),
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
