import 'package:flutter/material.dart';
import 'screens/counter_screen.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Counter',
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}
