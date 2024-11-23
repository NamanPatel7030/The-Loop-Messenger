import 'package:flutter/material.dart';
import 'create_name.dart'; // Import the Create Name screen

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  // List to store the OTP digits
  List<String> otpDigits = List.filled(4, ''); // 4 empty strings

  // Function to handle OTP input
  void onOtpEntered(int index, String value) {
    if (value.isNotEmpty && value.length == 1) {
      setState(() {
        otpDigits[index] = value; // Store the entered digit
      });

      // Automatically move to the next box after entering a digit
      if (index < 3) {
        FocusScope.of(context).nextFocus();
      }
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bold text for "Enter code"
            const Text(
              'Enter code',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24, // Adjust the size as needed
                color: Colors.black, // Darker text color
              ),
            ),
            const SizedBox(height: 10),

            // Instruction text
            const Text(
              'We’ve sent the code via SMS to your phone number.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87), // Darker instruction text
            ),
            const SizedBox(height: 20),

            // OTP input fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextField(
                      maxLength: 1, // Limit to 1 digit per box
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24, // Larger font for better visibility
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Darker text color
                      ),
                      decoration: const InputDecoration(
                        counterText: '', // Hides the character count indicator
                        border: InputBorder.none, // Removes underline
                      ),
                      onChanged: (value) => onOtpEntered(index, value), // Handle input
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Resend code option
            TextButton(
              onPressed: () {
                // Add logic for resending code
              },
              child: const Text(
                "Didn't get the code? Resend code",
                style: TextStyle(color: Colors.black), // Darker resend text
              ),
            ),
            const SizedBox(height: 20),

            // Continue button that stretches to the edges
            SizedBox(
              width: double.infinity, // Full width
              child: ElevatedButton(
                onPressed: () {
                  // Add logic for OTP validation here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateNameScreen()), // Navigate to the Create Name screen
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Black button background
                  foregroundColor: Colors.white, // White button text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
