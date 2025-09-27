import 'package:flutter/material.dart';

class RitualDetailScreen extends StatelessWidget {
  final String ritualId;
  
  const RitualDetailScreen({
    super.key,
    required this.ritualId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ritual Detayı'),
      ),
      body: Center(
        child: Text('Ritual Detail Screen - ID: $ritualId'),
      ),
    );
  }
}