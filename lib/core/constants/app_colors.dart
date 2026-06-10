import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Theme Colors ( Luxury Chocolate & Rose Gold / Pink Theme )
  static const Color background = Color(0xFF130907); // Very dark warm chocolate
  static const Color cardBg = Color(0xFF1D110E);     // Dark chocolate card background
  static const Color cardBorder = Color(0xFF33201B); // Thin brown border
  
  // Brand Colors
  static const Color primary = Color(0xFFD56B86); // Warm Rose Pink
  static const Color primaryGlow = Color(0x44D56B86);
  static const Color secondary = Color(0xFFE89FB0); // Light Rose/Beige-pink
  static const Color accent = Color(0xFFE6C175); // Soft Gold
  static const Color accentGlow = Color(0x22E6C175);
  
  // Status Colors
  static const Color success = Color(0xFF2E7D32); // Deep Green
  static const Color error = Color(0xFFC62828); // Deep Red
  static const Color warning = Color(0xFFEF6C00); // Orange-amber
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFBF8F7); // Warm Ivory
  static const Color textSecondary = Color(0xFFC7B1AC); // Pale Warm Brown
  static const Color textMuted = Color(0xFF8B7570); // Muted Warm Grey/Brown
  
  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFC45973)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient darkBackgroundGradient = LinearGradient(
    colors: [background, Color(0xFF22110D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient glassGradient = LinearGradient(
    colors: [
      Color(0x15FFFFFF),
      Color(0x05FFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
