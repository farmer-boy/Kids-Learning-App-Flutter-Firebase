import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../navigation/app_navigation.dart'; 
import 'home_page.dart';
import 'learn_page.dart';
import 'rewards_page.dart';
import 'profile_page.dart';

class MainAppScreen extends ConsumerWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppNavigation(
      pages: const [
        HomePage(),
        LearnPage(),
        RewardsPage(),
        ProfilePage(),
      ],
    );
  }
}