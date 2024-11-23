import 'package:chatapp_firebase/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'phone_input_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/loop_logo.png',  // Add the image path for your logo
                    height: 100,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'LOOP',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/onboarding_image.png',  // Replace with your image path
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Let's talk with your friends and family wherever and whenever",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Updated ElevatedButton with reduced horizontal padding
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => const LoginPage(),
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
                backgroundColor: Colors.black,  // Black background color for the button
                foregroundColor: Colors.white,  // White text color for the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50), // Reduced padding
              ),
              child: const Text(
                'Continue with phone',
                style: TextStyle(fontSize: 16),  // Adjust font size if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
