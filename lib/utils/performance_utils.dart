import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

/// Performance utilities for the RSU Delima app
class PerformanceUtils {
  PerformanceUtils._();

  /// Preload critical images to improve performance
  static Future<void> precacheImages(BuildContext context) async {
    if (!kIsWeb) {
      const imagePaths = [
        'assets/icons/logo_rsu_delima.png',
      ];

      final futures = imagePaths.map((path) {
        return precacheImage(AssetImage(path), context);
      }).toList();

      await Future.wait(futures);
    }
  }

  /// Optimize memory usage by clearing image cache when needed
  static void clearImageCache() {
    imageCache.clear();
    imageCache.clearLiveImages();
  }

  /// Set optimal image cache size based on device memory
  static void optimizeImageCache() {
    // Set cache size based on available memory
    imageCache.maximumSize = 100; // Maximum number of images
    imageCache.maximumSizeBytes = 50 << 20; // 50 MB cache
  }

  /// Haptic feedback for better user experience
  static void lightHaptic() {
    if (!kIsWeb) {
      HapticFeedback.lightImpact();
    }
  }

  static void mediumHaptic() {
    if (!kIsWeb) {
      HapticFeedback.mediumImpact();
    }
  }

  static void heavyHaptic() {
    if (!kIsWeb) {
      HapticFeedback.heavyImpact();
    }
  }
  /// Debounce function to prevent multiple rapid calls
  static Timer? _debounceTimer;
  
  static void debounce(VoidCallback callback, {Duration delay = const Duration(milliseconds: 300)}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, callback);
  }

  /// Calculate optimal list item extent for better performance
  static double calculateItemExtent(BuildContext context, {required double baseHeight}) {
    final mediaQuery = MediaQuery.of(context);
    final devicePixelRatio = mediaQuery.devicePixelRatio;
    
    // Adjust height based on device pixel ratio for better performance
    return baseHeight * (devicePixelRatio > 2 ? 0.9 : 1.0);
  }

  /// Get memory info for debugging
  static Map<String, dynamic> getMemoryInfo() {
    if (kDebugMode) {
      return {
        'imageCache_size': imageCache.currentSize,
        'imageCache_bytes': imageCache.currentSizeBytes,
        'imageCache_live': imageCache.liveImageCount,
      };
    }
    return {};
  }
}

/// Custom scroll behavior for better performance
class OptimizedScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const BouncingScrollPhysics();
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return Scrollbar(
          controller: details.controller,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }
}

/// Memory-efficient constants
class AppConstants {
  AppConstants._();

  // Cache commonly used values
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets smallPadding = EdgeInsets.all(8.0);
  static const EdgeInsets largePadding = EdgeInsets.all(24.0);
  
  static const BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(8.0));
  static const BorderRadius smallBorderRadius = BorderRadius.all(Radius.circular(4.0));
  static const BorderRadius largeBorderRadius = BorderRadius.all(Radius.circular(16.0));
  
  // Commonly used sizes
  static const double buttonHeight = 48.0;
  static const double iconSize = 24.0;
  static const double largeIconSize = 32.0;
  static const double smallIconSize = 16.0;
}
