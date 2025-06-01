import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Optimized theme configuration for RSU Delima app
class AppTheme {
  AppTheme._();
  // Color constants - Professional healthcare color scheme
  static const Color primaryColor = Color(0xFF1565C0); // Professional deep blue
  static const Color primaryColorDark = Color(0xFF0D47A1); // Darker blue for depth
  static const Color primaryColorLight = Color(0xFFE3F2FD); // Very light blue
  static const Color accentColor = Color(0xFF00695C); // Professional teal/green
  static const Color backgroundColor = Color(0xFFFAFAFA); // Clean off-white
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFD32F2F); // Clear red for errors
  static const Color successColor = Color(0xFF2E7D32); // Professional green
  static const Color warningColor = Color(0xFFED6C02); // Professional orange
  static const Color secondaryGreen = Color(0xFF388E3C); // Healthcare green
  static const Color lightGreen = Color(0xFFE8F5E8); // Light green background
  static const Color textPrimary = Color(0xFF212121); // Dark gray for text
  static const Color textSecondary = Color(0xFF757575); // Medium gray for secondary text
  // Text styles - Professional and accessible
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    color: textPrimary,
    height: 1.2,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.25,
    color: textPrimary,
    height: 1.3,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textPrimary,
    height: 1.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
    color: textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
    color: textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
    color: textSecondary,
    height: 1.4,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: textPrimary,
  );
  /// Get professional light theme for healthcare app
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      
      // App Bar theme - Professional and trustworthy
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),      // Card theme - Clean and professional
      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 3,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Elevated Button theme - Healthcare appropriate
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: primaryColor.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Text Button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Outlined Button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Input Decoration theme - Clean and accessible
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),        filled: true,
        fillColor: Colors.grey[50],
        hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
        labelStyle: const TextStyle(color: textSecondary, fontSize: 14),
        floatingLabelStyle: const TextStyle(color: primaryColor, fontSize: 14),
      ),

      // Bottom Navigation Bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12),
      ),

      // Text theme with professional styling
      textTheme: const TextTheme(
        headlineLarge: headingLarge,
        headlineMedium: headingMedium,
        headlineSmall: headingSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
      ),      // Divider theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE0E0E0),
        thickness: 1,
        space: 16,
      ),      // Chip theme
      chipTheme: const ChipThemeData(
        backgroundColor: primaryColorLight,
        selectedColor: primaryColor,
        labelStyle: TextStyle(color: textPrimary),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),

      // Visual density for better performance
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Animation theme
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
  /// Get optimized dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFF121212),
      
      // App Bar theme for dark mode
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F1F1F),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Card theme for dark mode
      cardTheme: CardTheme(
        color: const Color(0xFF1F1F1F),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Input decoration for dark mode
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF444444)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        hintStyle: const TextStyle(color: Color(0xFFB0B0B0)),
        labelStyle: const TextStyle(color: Color(0xFFE1E1E1)),
        floatingLabelStyle: const TextStyle(color: primaryColor),
      ),

      // Elevated Button theme for dark mode
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: labelLarge,
        ),
      ),

      // Text Button theme for dark mode
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: labelLarge,
        ),
      ),

      // Outlined Button theme for dark mode
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: labelLarge,
        ),
      ),

      // Bottom Navigation Bar theme for dark mode
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1F1F1F),
        selectedItemColor: primaryColor,
        unselectedItemColor: Color(0xFFB0B0B0),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Text theme for dark mode
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          color: Color(0xFFE1E1E1),
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
          color: Color(0xFFE1E1E1),
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFFE1E1E1),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.15,
          color: Color(0xFFE1E1E1),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.25,
          color: Color(0xFFE1E1E1),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4,
          color: Color(0xFFB0B0B0),
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: Color(0xFFE1E1E1),
        ),
      ),

      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Animation theme
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),        },
      ),
    );
  }

  /// Helper methods for healthcare-specific styling
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'active':
      case 'completed':
        return successColor;
      case 'pending':
      case 'scheduled':
        return warningColor;
      case 'cancelled':
      case 'rejected':
        return errorColor;
      default:
        return textSecondary;
    }
  }

  static Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
      case 'urgent':
        return errorColor;
      case 'medium':
        return warningColor;
      case 'low':
      case 'normal':
        return successColor;
      default:
        return primaryColor;
    }
  }
  /// Get box shadow for cards and elevated components
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 1,
      offset: const Offset(0, 1),
    ),
  ];

  /// Get professional gradient for background elements
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [primaryColor, primaryColorDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get accentGradient => const LinearGradient(
    colors: [accentColor, secondaryGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// Animation configurations for consistent performance
class AppAnimations {
  AppAnimations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;

  /// Slide transition from right
  static Widget slideFromRight(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: easeInOut,
      )),
      child: child,
    );
  }

  /// Fade transition
  static Widget fadeTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  /// Scale transition
  static Widget scaleTransition(Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: easeOut,
      )),
      child: child,
    );
  }
}
