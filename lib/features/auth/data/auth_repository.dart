import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StreamProvider<TempUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

final authRepositoryProvider = Provider((ref) => AuthRepository());

class TempUser {
  final String email;
  final String uid;
  final String? name;

  TempUser({required this.email, required this.uid, this.name});
}

class AuthRepository {
  final StreamController<TempUser?> _authStateController = StreamController<TempUser?>.broadcast();
  TempUser? _currentUser;

  final Map<String, String> _passwords = {};
  final Map<String, String> _uids = {};
  final Map<String, String> _names = {};

  AuthRepository() {
    // Seed a test user so the demo account works immediately
    _passwords['farhan@gmail.com'] = '123456';
    _uids['farhan@gmail.com'] = 'temp-uid-farhan';
    _names['farhan@gmail.com'] = 'Farhan';
    _authStateController.add(null);
  }

  Stream<TempUser?> authStateChanges() => _authStateController.stream;

  TempUser? get currentUser => _currentUser;

  Future<TempUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email.isEmpty || password.isEmpty) throw Exception('Email and password cannot be empty');
    if (!_passwords.containsKey(email)) throw Exception('No user found for that email.');
    if (_passwords[email] != password) throw Exception('Wrong password provided for that user.');
    String uid = _uids[email]!;
    String? name = _names[email];
    _currentUser = TempUser(email: email, uid: uid, name: name);
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  Future<TempUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email.isEmpty || password.isEmpty || name.isEmpty) throw Exception('Fields cannot be empty');
    if (password.length < 8) throw Exception('Password must be at least 8 characters');
    if (_passwords.containsKey(email)) throw Exception('User already exists');
    String uid = 'temp-uid-${DateTime.now().millisecondsSinceEpoch}';
    _passwords[email] = password;
    _uids[email] = uid;
    _names[email] = name;
    _currentUser = TempUser(email: email, uid: uid, name: name);
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _authStateController.add(null);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email.isEmpty) throw Exception('Email cannot be empty');
    print('Password reset email sent to $email');
  }
}