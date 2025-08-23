import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseMethods {
  Future<void> addUser(String userId, Map<String, dynamic> userInfoMap) async {
    try {
      await FirebaseFirestore.instance
          .collection("User") // 🔹 better practice: lowercase
          .doc(userId)
          .set(
            userInfoMap,
            SetOptions(merge: true),
          ); // 🔹 merge prevents overwrite
      debugPrint("✅ User $userId added/updated in Firestore");
    } catch (e) {
      debugPrint("❌ Error adding user: $e");
      rethrow;
    }
  }
}
