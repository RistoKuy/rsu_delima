@echo off
REM RSU Delima Build Optimization Script for Windows
REM This script optimizes the Flutter app for release builds

echo Starting RSU Delima App Optimization...

REM Clean previous builds
echo Cleaning previous builds...
flutter clean
flutter pub get

REM Analyze code for optimization opportunities
echo Running static analysis...
flutter analyze --no-fatal-infos

REM Generate optimized release build for Android
echo Building optimized release APK...
flutter build apk --release --obfuscate --split-debug-info=build/debug-info

REM Generate App Bundle for Google Play Store (smaller size)
echo Building optimized App Bundle...
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info

REM Generate size analysis
echo Generating build size analysis...
flutter build apk --analyze-size --target-platform android-arm64

REM Optional: Build for Web
REM echo Building for Web...
REM flutter build web --release --web-renderer html

echo.
echo Optimization complete!
echo.
echo Optimized builds available in:
echo - build\app\outputs\flutter-apk\app-release.apk
echo - build\app\outputs\bundle\release\app-release.aab
echo.
echo Size analysis available in build output above.
echo.
echo Additional optimizations applied:
echo ✓ ProGuard code shrinking and obfuscation
echo ✓ Resource shrinking
echo ✓ Image cache optimization
echo ✓ Performance-optimized widgets
echo ✓ Minimized build size
echo ✓ Smooth animations and transitions

pause
