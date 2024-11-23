import 'package:flutter/material.dart';
import 'home_page.dart';  // Import the message screen

class CreateNameScreen extends StatefulWidget {
  const CreateNameScreen({super.key});

  @override
  _CreateNameScreenState createState() => _CreateNameScreenState();
}

class _CreateNameScreenState extends State<CreateNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _warningMessage = '';

  // Function to validate the name input
  bool validateName(String value) {
    final validCharacters = RegExp(r'^[a-zA-Z0-9_ ]*$'); // Allow letters, numbers, underscores, and spaces
    if (!validCharacters.hasMatch(value)) {
      setState(() {
        _warningMessage = 'Special characters are not allowed, except for underscores and spaces.';
      });
      return false;
    } else {
      setState(() {
        _warningMessage = '';
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Create your name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Get more people to know your name',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Name',
              ),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                validateName(value); // Validate name as the user types
              },
            ),
            const SizedBox(height: 10),
            if (_warningMessage.isNotEmpty)
              Text(
                _warningMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Validate the name before navigation
                  if (validateName(_nameController.text) && _nameController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),  // Navigate to MessageScreen
                      ),
                    );
                  } else {
                    setState(() {
                      _warningMessage = 'Please correct the name before proceeding.'; // Set warning message
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
