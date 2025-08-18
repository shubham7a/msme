import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  // Factory method from Firebase User
  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      id: user.uid,
      name: user.displayName ?? "No Name",
      email: user.email ?? "No Email",
      photoUrl: user.photoURL,
    );
  }

  // Convert to map (useful for saving in Firestore/Realtime DB)
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "email": email, "photoUrl": photoUrl};
  }

  // Create from map (for reading back from DB)
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map["id"],
      name: map["name"],
      email: map["email"],
      photoUrl: map["photoUrl"],
    );
  }
}
