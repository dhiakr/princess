import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // Spacing values
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 16.0;
  static const double l = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // SizedBox Heights
  static const SizedBox hXs = SizedBox(height: xs);
  static const SizedBox hS = SizedBox(height: s);
  static const SizedBox hM = SizedBox(height: m);
  static const SizedBox hL = SizedBox(height: l);
  static const SizedBox hXl = SizedBox(height: xl);
  static const SizedBox hXxl = SizedBox(height: xxl);
  static const SizedBox hXxxl = SizedBox(height: xxxl);

  // SizedBox Widths
  static const SizedBox wXs = SizedBox(width: xs);
  static const SizedBox wS = SizedBox(width: s);
  static const SizedBox wM = SizedBox(width: m);
  static const SizedBox wL = SizedBox(width: l);
  static const SizedBox wXl = SizedBox(width: xl);
  static const SizedBox wXxl = SizedBox(width: xxl);

  // Padding
  static const EdgeInsets pAllXs = EdgeInsets.all(xs);
  static const EdgeInsets pAllS = EdgeInsets.all(s);
  static const EdgeInsets pAllM = EdgeInsets.all(m);
  static const EdgeInsets pAllL = EdgeInsets.all(l);
  static const EdgeInsets pAllXl = EdgeInsets.all(xl);

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 16.0;
  static const double radiusL = 24.0;
  static const double radiusXl = 32.0;

  static const BorderRadius borderRadiusS = BorderRadius.all(Radius.circular(radiusS));
  static const BorderRadius borderRadiusM = BorderRadius.all(Radius.circular(radiusM));
  static const BorderRadius borderRadiusL = BorderRadius.all(Radius.circular(radiusL));
  static const BorderRadius borderRadiusXl = BorderRadius.all(Radius.circular(radiusXl));
}
