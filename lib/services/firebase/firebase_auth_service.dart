import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

class FirebaseAuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      throw Exception('Giriş başarısız: $e');
    }
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      throw Exception('Kayıt başarısız: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService(ref.watch(firebaseAuthProvider));
});
