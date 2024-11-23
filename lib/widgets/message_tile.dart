import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;

  const MessageTile({
    super.key,
    required this.message,
    required this.sender,
    required this.sentByMe,
  });

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: widget.sentByMe ? 0 : 24,
        right: widget.sentByMe ? 24 : 0,
      ),
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sentByMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.only(
          top: 14,
          bottom: 14,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: widget.sentByMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
          gradient: LinearGradient(
            colors: widget.sentByMe
                ? [Colors.blueAccent, Colors.blue]
                : [const Color(0xFFFFFFFF), const Color(0xFFFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sender.toUpperCase(),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: widget.sentByMe
                    ? Colors.white
                    : Colors.black, // Adjust sender name color
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.message,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 50, 50, 50),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 120, 120, 120)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Chat',
          style: TextStyle(color: Color.fromARGB(255, 143, 143, 143)),
        ),
      ),
      backgroundColor: const Color(0xFF121212), // Dark background
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: const [
          MessageTile(
            message: "Hello! How are you?",
            sender: "Alice",
            sentByMe: false,
          ),
          MessageTile(
            message: "I'm good, thanks! How about you?",
            sender: "Me",
            sentByMe: true,
          ),
          MessageTile(
            message: "Doing well, just working on some Flutter code!",
            sender: "Alice",
            sentByMe: false,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ChatScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
