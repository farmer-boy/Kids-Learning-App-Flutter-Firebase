import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart'; // Import TempUser and repo

final authStateProvider = StreamProvider<TempUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});