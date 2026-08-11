import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text('Flutter Counter'),
        backgroundColor: const Color(0xFF6200EE),
        foregroundColor: const Color(0xFFFFFFFF),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
              textAlign: TextAlign.center,
            ),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w200,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        backgroundColor: const Color(0xFF6200EE),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
