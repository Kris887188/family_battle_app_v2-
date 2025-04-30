import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_service.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;

  Future<void> signInWithEmail(String email) async {
    try {
      final cred = await _auth.signInAnonymously();
      currentUser = cred.user;
      notifyListeners();
      if (currentUser != null) {
        await FirestoreService().subscribeToFamilyTopic(currentUser!.uid);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthError [${e.code}]: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unknown auth error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    currentUser = null;
    notifyListeners();
  }
}
