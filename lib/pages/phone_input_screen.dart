import 'package:flutter/material.dart';
import 'otp_verification_screen.dart'; // Import the OTP screen

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  _PhoneInputScreenState createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  String selectedCountry = "India (+91)";
  String selectedCountryCode = "+91"; // Default country code

  // A list of country names with their country codes
  final List<Map<String, String>> countries = [
    {'name': 'India', 'code': '+91'},
    {'name': 'United States', 'code': '+1'},
    {'name': 'United Kingdom', 'code': '+44'},
    {'name': 'Australia', 'code': '+61'},
    {'name': 'Canada', 'code': '+1'},
    {'name': 'Germany', 'code': '+49'},
    {'name': 'France', 'code': '+33'},
    {'name': 'Italy', 'code': '+39'},
    {'name': 'Spain', 'code': '+34'},
    {'name': 'Netherlands', 'code': '+31'},
    {'name': 'Japan', 'code': '+81'},
    {'name': 'China', 'code': '+86'},
    {'name': 'Brazil', 'code': '+55'},
    {'name': 'Russia', 'code': '+7'},
    {'name': 'Mexico', 'code': '+52'},
    {'name': 'South Africa', 'code': '+27'},
    {'name': 'New Zealand', 'code': '+64'},
    {'name': 'Singapore', 'code': '+65'},
    {'name': 'Sweden', 'code': '+46'},
    {'name': 'Norway', 'code': '+47'},
    {'name': 'Denmark', 'code': '+45'},
    {'name': 'Finland', 'code': '+358'},
    {'name': 'Ireland', 'code': '+353'},
    {'name': 'Belgium', 'code': '+32'},
    {'name': 'Austria', 'code': '+43'},
    {'name': 'Switzerland', 'code': '+41'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar background transparent
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the home page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bold and centered heading for phone input
            const Text(
              'Enter your phone number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle text below the heading
            const Text(
              'Please confirm your region and enter your phone number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Country selection dropdown with padding and adjusted styling
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedCountry,
                decoration: const InputDecoration(
                  border: InputBorder.none, // Remove default border to avoid clutter
                  isDense: true, // Makes the dropdown more compact
                  contentPadding: EdgeInsets.symmetric(vertical: 12), // Vertical padding inside the box
                ),
                isExpanded: true, // Ensures the text fits within the dropdown box
                items: countries.map<DropdownMenuItem<String>>((Map<String, String> country) {
                  return DropdownMenuItem<String>(
                    value: '${country['name']} (${country['code']})',
                    child: Text('${country['name']} (${country['code']})'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCountry = newValue!;
                    selectedCountryCode = newValue.split(' ').last.replaceAll('(', '').replaceAll(')', '');
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            // Phone input field with consistent text styling
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  // Prefix country code
                  Text(
                    selectedCountryCode,
                    style: const TextStyle(
                      fontSize: 16, // Matching font size with the input
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10), // Add spacing between prefix and input field
                  const Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 16), // Ensuring consistent font size
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Grey color for placeholder
                        ),
                        border: InputBorder.none, // Remove the border for a cleaner look
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Full-width button with updated style
            SizedBox(
              width: double.infinity, // Full width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) => const VerificationCodeScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end);
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(position: offsetAnimation, child: child);
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Black button background
                  foregroundColor: Colors.white, // White button text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Circular button
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
