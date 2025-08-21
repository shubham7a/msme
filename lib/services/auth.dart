import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:msme/models/app_user.dart';
import 'package:msme/services/database.dart';

void showLoadingDialog(BuildContext context, {String message = "Loading..."}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(message),
            ],
          ),
        ),
      );
    },
  );
}

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  /// 🔹 Google Sign In
  Future<AppUser?> signInWithGoogle(BuildContext context) async {
    try {
      showLoadingDialog(context, message: "Signing in with Google...");

      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
      );
      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

      if (googleAccount == null) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google sign-in cancelled.")),
        );
        return null;
      }

      final googleAuth = await googleAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final result = await auth.signInWithCredential(credential);
      final user = result.user;
      debugPrint("User signed : ${user?.toString()}");

      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      if (user != null) {
        // 🔎 Fix for email being null
        String? email = user.email;
        if (email == null || email.isEmpty) {
          for (var profile in user.providerData) {
            if (profile.providerId == "google.com") {
              email = profile.email;
              break;
            }
          }
        }

        debugPrint("✅ User signed in: ${user.displayName}, $email");

        // Create AppUser model
        final appUser = AppUser(
          id: user.uid,
          name: user.displayName ?? "No Name",
          email: email ?? "No Email",
          photoUrl: user.photoURL,
        );

        await DatabaseMethods().addUser(appUser.id, appUser.toMap());

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login successful! 🎉"),
            backgroundColor: Colors.green,
          ),
        );

        return appUser; // ✅ Return model
      }
      return null;
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Google sign-in failed: $e")));
      return null;
    }
  }

  /// 🔹 Facebook Sign In
  Future<AppUser?> signInWithFacebook(BuildContext context) async {
    try {
      showLoadingDialog(context, message: "Signing in with Facebook...");

      final LoginResult loginResult = await facebookAuth.login(
        permissions: ['email', 'public_profile'],
      );

      if (loginResult.status == LoginStatus.success) {
        final facebookAuthCredential = FacebookAuthProvider.credential(
          loginResult.accessToken!.tokenString,
        );

        final result = await auth.signInWithCredential(facebookAuthCredential);
        final user = result.user;

        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        if (user != null) {
          final appUser = AppUser.fromFirebaseUser(user);

          await DatabaseMethods().addUser(appUser.id, appUser.toMap());

          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Facebook login successful 🎉"),
              backgroundColor: Colors.green,
            ),
          );

          return appUser; // ✅ Return model
        }
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Facebook login failed: ${loginResult.message}"),
          ),
        );
      }
      return null;
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Facebook sign-in failed: $e")));
      return null;
    }
  }

  // Future<void> signOutUser(BuildContext context) async {
  //   try {
  //     await auth.signOut();

  //     try {
  //       await GoogleSignIn().signOut();
  //     } catch (_) {
  //       // ignore: use_build_context_synchronously
  //       ScaffoldMessenger.of(
  //         // ignore: use_build_context_synchronously
  //         context,
  //       ).showSnackBar(SnackBar(content: Text("Error signing out of Google")));
  //     }

  //     try {
  //       await FacebookAuth.instance.logOut();
  //     } catch (_) {
  //       // ignore: use_build_context_synchronously
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Error signing out of Facebook")),
  //       );
  //     }

  //     ScaffoldMessenger.of(
  //       // ignore: use_build_context_synchronously
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text("Logged out successfully.")));
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       // ignore: use_build_context_synchronously
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("Error logging out: $e")));
  //   }
  // }

  Future<void> signOutUser() async {
    try {
      await auth.signOut();
    } catch (e) {
      debugPrint("Error signing out Firebase: $e");
    }

    try {
      await googleSignIn.signOut();
    } catch (e) {
      debugPrint("Error signing out Google: $e");
    }

    try {
      await facebookAuth.logOut();
    } catch (e) {
      debugPrint("Error signing out Facebook: $e");
    }
  }
}
