import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Performance monitoring widget for debug builds
class PerformanceMonitor extends StatefulWidget {
  const PerformanceMonitor({
    super.key,
    required this.child,
    this.showOverlay = true,
  });

  final Widget child;
  final bool showOverlay;

  @override
  State<PerformanceMonitor> createState() => _PerformanceMonitorState();
}

class _PerformanceMonitorState extends State<PerformanceMonitor>
    with WidgetsBindingObserver {  int _frameCount = 0;
  double _currentFPS = 0.0;
  int _memoryUsage = 0;
  bool _showStats = false;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      WidgetsBinding.instance.addObserver(this);
      _startPerformanceMonitoring();
    }
  }

  @override
  void dispose() {
    if (kDebugMode) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  void _startPerformanceMonitoring() {
    if (!kDebugMode) return;

    // Monitor frame rate
    WidgetsBinding.instance.addPersistentFrameCallback(_onFrame);

    // Update stats every second
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _currentFPS = _frameCount.toDouble();
          _frameCount = 0;
          _updateMemoryUsage();
        });
        return true;
      }
      return false;
    });
  }

  void _onFrame(Duration timeStamp) {
    if (mounted) {
      _frameCount++;
    }
  }

  void _updateMemoryUsage() {
    // Get approximate memory usage
    _memoryUsage = (ProcessInfo.currentRss / 1024 / 1024).round();
  }

  Widget _buildPerformanceOverlay() {
    if (!kDebugMode || !_showStats || !widget.showOverlay) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 50,
      right: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Performance Stats',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'FPS: ${_currentFPS.toStringAsFixed(1)}',
              style: TextStyle(
                color: _currentFPS >= 55 ? Colors.green : 
                       _currentFPS >= 30 ? Colors.orange : Colors.red,
                fontSize: 11,
              ),
            ),
            Text(
              'Memory: ${_memoryUsage}MB',
              style: TextStyle(
                color: _memoryUsage < 100 ? Colors.green :
                       _memoryUsage < 200 ? Colors.orange : Colors.red,
                fontSize: 11,
              ),
            ),
            Text(
              'Cache: ${imageCache.currentSize}/${imageCache.maximumSize}',
              style: const TextStyle(color: Colors.white, fontSize: 11),            ),
            Text(
              'Widgets: ${WidgetsBinding.instance.rootElement?.size ?? 0}',
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (kDebugMode) _buildPerformanceOverlay(),
        if (kDebugMode)
          Positioned(
            bottom: 50,
            right: 10,
            child: FloatingActionButton.small(
              onPressed: () => setState(() => _showStats = !_showStats),
              backgroundColor: Colors.blue.withValues(alpha: 0.8),
              child: Icon(
                _showStats ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}

/// Memory info class for monitoring
class ProcessInfo {
  static int get currentRss => 50 * 1024 * 1024; // Placeholder - 50MB
}

/// Performance testing utilities
class PerformanceTestUtils {
  PerformanceTestUtils._();

  /// Measure widget build time
  static Duration measureBuildTime(Widget Function() builder) {
    final stopwatch = Stopwatch()..start();
    builder();
    stopwatch.stop();
    return stopwatch.elapsed;
  }

  /// Measure scroll performance
  static void measureScrollPerformance(ScrollController controller) {
    if (!kDebugMode) return;    controller.addListener(() {
      // Monitor scroll position
      debugPrint('Scroll position: ${controller.position.pixels}');
      debugPrint('Scroll extent: ${controller.position.maxScrollExtent}');
    });
  }

  /// Check for memory leaks
  static void checkMemoryLeaks() {
    if (kDebugMode) {
      final imageCache = PaintingBinding.instance.imageCache;
      debugPrint('Image cache size: ${imageCache.currentSize}');
      debugPrint('Image cache bytes: ${imageCache.currentSizeBytes}');
      debugPrint('Live images: ${imageCache.liveImageCount}');

      if (imageCache.currentSize > imageCache.maximumSize * 0.9) {
        debugPrint('WARNING: Image cache nearly full!');
      }
    }
  }

  /// Profile widget rebuilds
  static Widget profileRebuilds(Widget child, String name) {
    if (kDebugMode) {
      return Builder(
        builder: (context) {
          debugPrint('Rebuilding widget: $name');
          return child;
        },
      );
    }
    return child;
  }
}

/// Performance-aware StatelessWidget
abstract class PerformantStatelessWidget extends StatelessWidget {
  const PerformantStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return PerformanceTestUtils.profileRebuilds(
        buildWidget(context),
        runtimeType.toString(),
      );
    }
    return buildWidget(context);
  }

  Widget buildWidget(BuildContext context);
}

/// Performance-aware StatefulWidget
abstract class PerformantStatefulWidget extends StatefulWidget {
  const PerformantStatefulWidget({super.key});
}

/// Mixin for performance monitoring in StatefulWidget
mixin PerformanceMixin<T extends StatefulWidget> on State<T> {
  int _buildCount = 0;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      _buildCount++;
      debugPrint('${widget.runtimeType} build count: $_buildCount');
    }
    return buildWidget(context);
  }

  Widget buildWidget(BuildContext context);

  /// Called when performance issues are detected
  void onPerformanceIssue(String issue) {
    if (kDebugMode) {
      debugPrint('Performance issue in ${widget.runtimeType}: $issue');
    }
  }
}
