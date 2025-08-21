import 'package:flutter/material.dart';
import 'package:msme/screen/home.dart';
import 'package:msme/screen/onboarding_page.dart';
import 'package:msme/screen/widget/bottom_navigation.dart';
import 'package:msme/services/auth.dart';
import 'package:msme/services/widget_support.dart'; // Assuming this has AppWidget.normaltextstyle

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Text(
          "Login Page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingPage()),
              (route) => false, // remove all previous routes
            );
          },
        ),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            const Text(
              "Welcome to the Login Page",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 40),

            // Google Sign In Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: () async {
                    final appUser = await AuthMethods().signInWithGoogle(
                      context,
                    );
                    if (appUser != null) {
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavigation(),
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.g_mobiledata,
                          color: Colors.red,
                          size: 30,
                        ), // Google Icon
                        const SizedBox(width: 12),
                        Text(
                          "Sign in with Google",
                          style: AppWidget.normaltextstyle(20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Facebook Sign In Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: () async {
                    final appUser = await AuthMethods().signInWithFacebook(
                      context,
                    );
                    if (appUser != null) {
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(user: appUser),
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 30,
                        ), // Facebook Icon
                        const SizedBox(width: 12),
                        Text(
                          "Sign in with Facebook",
                          style: AppWidget.normaltextstyle(20),
                        ),
                      ],
                    ),
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
