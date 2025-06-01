import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For performance optimizations
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations for better performance
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Hide status bar for immersive experience
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  
  // Optimize image cache
  PaintingBinding.instance.imageCache.maximumSize = 100;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20; // 50 MB
  
  runApp(const RSUDelimaApp());
}

class RSUDelimaApp extends StatelessWidget {
  const RSUDelimaApp({super.key});

  @override
  Widget build(BuildContext context) {    return MaterialApp(
      title: 'RSU Delima',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light, // Force light mode for professional, inclusive design
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      // Disable implicit animations for better performance
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0), // Prevent text scaling issues
          ),
          child: child!,
        );
      },
      // Enable performance overlay in debug mode
      showPerformanceOverlay: false,
    );
  }
}
