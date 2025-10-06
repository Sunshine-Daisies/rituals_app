import 'package:flutter/material.dart';
import '../services/llm_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _promptController = TextEditingController();
  String _response = '';
  String _errorMessage = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _sendPrompt({bool useJsonFormat = false}) async {
    final prompt = _promptController.text.trim();
    
    if (prompt.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a prompt';
        _response = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _response = '';
    });

    try {
      if (useJsonFormat) {
        // Yeni RitualIntent sistemi kullan
        final ritualIntent = await LlmService.inferRitualIntent(prompt);
        
        // RitualIntent'i güzel bir formatta göster
        final responseText = '''
Intent: ${ritualIntent.intent}
Ritual Name: ${ritualIntent.ritualName ?? 'N/A'}
Steps: ${ritualIntent.steps?.join(', ') ?? 'N/A'}
Reminder Time: ${ritualIntent.reminderTime ?? 'N/A'}
Reminder Days: ${ritualIntent.reminderDays?.join(', ') ?? 'N/A'}
        ''';
        
        setState(() {
          _response = responseText;
          _isLoading = false;
        });
      } else {
        // Normal chat
        final response = await LlmService.getChatResponse(prompt);
        setState(() {
          _response = response;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Hata: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenAI Chat - Normal & JSON'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Prompt input field
            TextField(
              controller: _promptController,
              decoration: const InputDecoration(
                labelText: 'Enter your prompt',
                hintText: 'Type your question or message here...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendPrompt(useJsonFormat: false),
            ),
            const SizedBox(height: 16),
            
            // Send buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : () => _sendPrompt(useJsonFormat: false),
                    child: _isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              SizedBox(width: 8),
                              Text('Loading...'),
                            ],
                          )
                        : const Text('Normal Chat'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isLoading ? null : () => _sendPrompt(useJsonFormat: true),
                    child: const Text('JSON Ritual'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Response or error display
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _errorMessage.isNotEmpty 
                        ? Colors.red.shade300 
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: _errorMessage.isNotEmpty
                      ? Colors.red.shade50
                      : Colors.grey.shade50,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _errorMessage.isNotEmpty ? 'Error:' : 'Response:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _errorMessage.isNotEmpty 
                              ? Colors.red.shade700 
                              : Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 14,
                          ),
                        )
                      else if (_response.isNotEmpty)
                        Text(
                          _response,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.4,
                          ),
                        )
                      else if (!_isLoading)
                        Text(
                          'No response yet. Enter a prompt and click send.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}