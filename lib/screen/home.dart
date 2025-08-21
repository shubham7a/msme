import 'package:flutter/material.dart';
import 'package:msme/models/app_user.dart';

class Home extends StatefulWidget {
  final AppUser user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Welcome to the Home Page ${widget.user.name}",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                // await AuthMethods().signOutUser(context);

                // // ✅ Show snackbar on logout button press
                // // ignore: use_build_context_synchronously
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text("Logout successful"),
                //     backgroundColor: Colors.green,
                //   ),
                // );
                // Navigator.pushReplacement(
                //   // ignore: use_build_context_synchronously
                //   context,
                //   MaterialPageRoute(builder: (context) => const LoginPage()),
                // );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
