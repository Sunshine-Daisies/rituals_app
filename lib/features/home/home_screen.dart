import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rituallerim'),
      ),
      body: const Center(
        child: Text('Home Screen - Coming Soon'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to chat
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}