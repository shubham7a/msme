import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msme/screen/widget/custom_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    // debugPrint("Current User: $user");
    final String displayName =
        user?.displayName ?? user?.providerData.first.displayName ?? "Guest";
    final String email =
        user?.email ?? user?.providerData.first.email ?? "No Email";
    final String photoUrl =
        user?.photoURL ?? user?.providerData.first.photoURL ?? "";
    //debugPrint("User Info: $displayName, $email, $photoUrl");

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.teal),
            currentAccountPicture: CircleAvatar(
              radius: 40,
              // ignore: unnecessary_null_comparison
              backgroundImage: photoUrl != null
                  ? NetworkImage(photoUrl)
                  : const AssetImage("assets/images/default_avatar.png")
                        as ImageProvider,
            ),
            accountName: Text(
              displayName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(email, style: const TextStyle(fontSize: 14)),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text(
              "Template Message",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              "Agents",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(
              "Submit Feedback",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text(
              "Help & Support",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              "Logout",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),

            onTap: () {
              Navigator.of(context, rootNavigator: true).pop(); // close Drawer
              CustomDialog.show(context); // safe because uses rootNavigator
            },
          ),
        ],
      ),
    );
  }
}
