import 'package:chatapp_firebase/service/chat_gpt_service.dart';
import 'package:flutter/material.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ChatGPTService _chatService = ChatGPTService(); // Initialize ChatGPT service
  String _chatResponse = ""; // To store AI responses
  bool _isLoading = false; // Loading state

  // Method to send a message and fetch the AI's response
  void _sendMessage() async {
    final String userMessage = _controller.text.trim();

    if (userMessage.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _chatResponse = "Thinking...";
      });

      try {
        // Fetch AI response
        final String aiResponse = await _chatService.sendMessage(userMessage);
        setState(() {
          _chatResponse = aiResponse;
        });
      } catch (e) {
        setState(() {
          _chatResponse = "Error fetching response. Please try again.";
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
        _controller.clear(); // Clear input field after sending
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chat"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AI Response:",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 10),
                    _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            _chatResponse,
                            style: const TextStyle(fontSize: 16),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _sendMessage,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("Send"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
