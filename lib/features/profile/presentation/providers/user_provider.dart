import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../services/local_db/isar_service.dart';
import '../../data/local_user.dart';

class UserNotifier extends StateNotifier<LocalUser?> {
  final IsarService _isarService;

  UserNotifier(this._isarService) : super(null) {
    _loadUser();
    _listenToFirebaseAuth();
  }

  void _listenToFirebaseAuth() {
    try {
      if (Firebase.apps.isNotEmpty) {
        FirebaseAuth.instance.authStateChanges().listen((fbUser) async {
          if (fbUser != null) {
            try {
              final doc = await FirebaseFirestore.instance.collection('users').doc(fbUser.uid).get().timeout(const Duration(seconds: 2));
              if (doc.exists) {
                final data = doc.data()!;
                updateUser(
                  email: data['email'] as String? ?? fbUser.email,
                  name: data['name'] as String? ?? fbUser.displayName ?? 'Kullanıcı',
                  surname: data['surname'] as String?,
                  profilePicturePath: data['profilePicturePath'] as String? ?? fbUser.photoURL,
                  selectedCity: data['selectedCity'] as String?,
                );
                return;
              }
            } catch (_) {}
            
            updateUser(
              email: fbUser.email,
              name: (fbUser.displayName != null && fbUser.displayName!.isNotEmpty) ? fbUser.displayName : 'Kullanıcı',
              profilePicturePath: fbUser.photoURL,
            );
          }
        }, onError: (_) {});
      }
    } catch (_) {}
  }

  Future<void> _loadUser() async {
    LocalUser? user;
    try {
      user = await _isarService.getUser();
    } catch (_) {}
    
    if (user != null) {
      state = user;
    } else {
      final newUser = LocalUser()
        ..name = null
        ..surname = null
        ..email = null;
      try {
        await _isarService.saveUser(newUser);
      } catch (_) {}
      state = newUser;
    }
  }

  Future<void> updateUser({
    String? name,
    String? surname,
    String? email,
    String? profilePicturePath,
    bool? isFaceIdEnabled,
    String? geminiApiKey,
    String? selectedCity,
    List<String>? connectedInstitutions,
  }) async {
    LocalUser? currentUser = state;
    if (currentUser == null) {
      try {
        currentUser = await _isarService.getUser();
      } catch (_) {}
    }
    currentUser ??= LocalUser();
    
    final updatedUser = LocalUser()
      ..id = currentUser.id
      ..name = name ?? currentUser.name
      ..surname = surname ?? currentUser.surname
      ..email = email ?? currentUser.email
      ..profilePicturePath = profilePicturePath ?? currentUser.profilePicturePath
      ..isFaceIdEnabled = isFaceIdEnabled ?? currentUser.isFaceIdEnabled
      ..geminiApiKey = geminiApiKey ?? currentUser.geminiApiKey
      ..selectedCity = selectedCity ?? currentUser.selectedCity
      ..connectedInstitutions = connectedInstitutions ?? currentUser.connectedInstitutions;

    try {
      await _isarService.saveUser(updatedUser);
    } catch (_) {}
    state = updatedUser;

    try {
      final fbUser = FirebaseAuth.instance.currentUser;
      if (fbUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(fbUser.uid).set({
          'name': updatedUser.name,
          'surname': updatedUser.surname,
          'email': updatedUser.email,
          'profilePicturePath': updatedUser.profilePicturePath,
          'selectedCity': updatedUser.selectedCity,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true)).timeout(const Duration(seconds: 2));
      }
    } catch (_) {}
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}

    LocalUser? currentUser = state;
    if (currentUser == null) {
      try {
        currentUser = await _isarService.getUser();
      } catch (_) {}
    }
    currentUser ??= LocalUser();
    
    final loggedOutUser = LocalUser()
      ..id = currentUser.id
      ..name = null
      ..surname = null
      ..email = null
      ..profilePicturePath = null
      ..isFaceIdEnabled = currentUser.isFaceIdEnabled
      ..geminiApiKey = currentUser.geminiApiKey
      ..connectedInstitutions = currentUser.connectedInstitutions;

    try {
      await _isarService.saveUser(loggedOutUser);
    } catch (_) {}
    state = loggedOutUser;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, LocalUser?>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return UserNotifier(isarService);
});
