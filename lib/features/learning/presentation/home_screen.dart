import 'package:flutter/material.dart';
import '../../../core/navigation/app_navigation.dart';
import 'pages/home_page.dart';
import 'pages/learn_page.dart';
import 'pages/rewards_page.dart';
import 'pages/profile_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
