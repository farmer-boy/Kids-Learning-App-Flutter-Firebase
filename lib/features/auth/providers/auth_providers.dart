import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdk_setup/features/auth/data/auth_repository.dart'; // Imports TempUser and authRepositoryProvider from repo

// Dedicated file for auth providers – easy to import everywhere
final authStateProvider = StreamProvider<TempUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});