import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryDark = Color(0xFF1A1A1A); // Mat black
  static const Color primaryGold = Color(0xFFD4AF37); // Royal gold
  static const Color accentGold =
      Color(0xFFFAD02C); // Bright gold for highlights

  // Background Colors
  static const Color background =
      Color(0xFF121212); // Darker black for background
  static const Color surface =
      Color(0xFF1E1E1E); // Slightly lighter black for cards
  static const Color overlay = Color(0xFF2D2D2D); // For overlays and modals

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF); // White text
  static const Color textSecondary = Color(0xFFB3B3B3); // Light grey text
  static const Color textGold = primaryGold; // Gold text

  // Status Colors
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color error = Color(0xFFFF5252); // Red
  static const Color warning = Color(0xFFFFB74D); // Orange
  static const Color info = Color(0xFF64B5F6); // Blue

  // Category Colors (for different learning sections)
  static const Color alphabetColor = Color(0xFF7E57C2); // Purple for Alphabet
  static const Color mathColor = Color(0xFF26A69A); // Teal for Math
  static const Color scienceColor = Color(0xFF42A5F5); // Blue for Science
  static const Color artColor = Color(0xFFEF5350); // Red for Art

  // Gradient Colors
  static const List<Color> goldGradient = [
    Color(0xFFD4AF37),
    Color(0xFFF7EF8A),
    Color(0xFFD4AF37),
  ];

  static const List<Color> darkGradient = [
    Color(0xFF1A1A1A),
    Color(0xFF2D2D2D),
  ];
}
