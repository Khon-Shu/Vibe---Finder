import 'package:flutter/material.dart';

class ResponsiveHelper {
  // Breakpoint definitions for different mobile platforms
  static const double smallMobile = 320;   // iPhone SE
  static const double mobile = 375;        // iPhone 12/13
  static const double largeMobile = 414;   // iPhone 12/13 Pro Max
  static const double tablet = 768;        // iPad
  static const double largeTablet = 1024;  // iPad Pro

  // Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Check device type
  static bool isSmallMobile(BuildContext context) => getScreenWidth(context) < mobile;
  static bool isMobile(BuildContext context) => getScreenWidth(context) >= smallMobile && getScreenWidth(context) < largeMobile;
  static bool isLargeMobile(BuildContext context) => getScreenWidth(context) >= largeMobile && getScreenWidth(context) < tablet;
  static bool isTablet(BuildContext context) => getScreenWidth(context) >= tablet;

  // Responsive value based on screen width
  static double responsiveValue(BuildContext context, {
    required double small,
    required double medium,
    required double large,
  }) {
    final width = getScreenWidth(context);
    if (width < mobile) return small;
    if (width < largeMobile) return medium;
    return large;
  }

  // Responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: responsiveValue(context,
        small: 16,
        medium: 20,
        large: 24,
      ),
      vertical: responsiveValue(context,
        small: 16,
        medium: 20,
        large: 32,
      ),
    );
  }

  // Responsive font size
  static double responsiveFontSize(BuildContext context, {
    required double small,
    required double medium,
    required double large,
  }) {
    return responsiveValue(context, small: small, medium: medium, large: large);
  }

  // Responsive border radius
  static double responsiveBorderRadius(BuildContext context) {
    return responsiveValue(context,
      small: 12,
      medium: 16,
      large: 20,
    );
  }

  // Responsive icon size
  static double responsiveIconSize(BuildContext context) {
    return responsiveValue(context,
      small: 20,
      medium: 24,
      large: 28,
    );
  }

  // Responsive spacing
  static double responsiveSpacing(BuildContext context) {
    return responsiveValue(context,
      small: 8,
      medium: 16,
      large: 24,
    );
  }

  // Responsive container height
  static double responsiveContainerHeight(BuildContext context, double baseHeight) {
    final screenHeight = getScreenHeight(context);
    if (screenHeight < 600) return baseHeight * 0.8;  // Small screens
    if (screenHeight < 800) return baseHeight * 0.9;  // Medium screens
    return baseHeight;  // Large screens
  }

  // Grid columns for responsive layout
  static int getGridColumns(BuildContext context) {
    if (isTablet(context)) return 3;
    if (isLargeMobile(context)) return 2;
    return 1;
  }

  // Responsive aspect ratio
  static double getAspectRatio(BuildContext context) {
    if (isTablet(context)) return 16 / 9;
    if (isLargeMobile(context)) return 3 / 2;
    return 4 / 3;
  }
}
