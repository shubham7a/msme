import 'package:flutter/material.dart';
import 'package:msme/screen/login_page.dart';
import 'package:msme/services/auth.dart';

class CustomDialog {
  static void show(BuildContext context) {
    // Use root context for safety
    final rootContext = Navigator.of(context, rootNavigator: true).context;

    showDialog(
      context: rootContext,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.exit_to_app, size: 50, color: Colors.red),
              const SizedBox(height: 15),
              const Text(
                "Logout?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Are you sure you want to log out of your account?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  // Cancel
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onTap: () => Navigator.of(ctx).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Logout
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onTap: () async {
                        // 1. Close confirm dialog first
                        Navigator.of(rootContext, rootNavigator: true).pop();

                        try {
                          // 3. Perform logout
                          await AuthMethods().signOutUser();

                          // 4. Close spinner
                          // ignore: use_build_context_synchronously
                          Navigator.of(rootContext, rootNavigator: true).pop();

                          // 5. Show success snackbar
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(rootContext).showSnackBar(
                            const SnackBar(
                              content: Text("Logged out successfully ✅"),
                              backgroundColor: Colors.green,
                            ),
                          );

                          // 6. Navigate to login page
                          // ignore: use_build_context_synchronously
                          Navigator.of(rootContext).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                        } catch (e) {
                          // Close spinner and show error
                          // ignore: use_build_context_synchronously
                          Navigator.of(rootContext, rootNavigator: true).pop();
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(rootContext).showSnackBar(
                            SnackBar(
                              content: Text("Logout failed: $e"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
