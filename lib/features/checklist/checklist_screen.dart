import 'package:flutter/material.dart';

class ChecklistScreen extends StatelessWidget {
  final String runId;
  
  const ChecklistScreen({
    super.key,
    required this.runId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ritual Checklist'),
      ),
      body: Center(
        child: Text('Checklist Screen - Run ID: $runId'),
      ),
    );
  }
}