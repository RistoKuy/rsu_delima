import 'package:flutter/material.dart';

/// Optimized StatelessWidget base class with const constructor enforcement
abstract class OptimizedStatelessWidget extends StatelessWidget {
  const OptimizedStatelessWidget({super.key});
}

/// Optimized StatefulWidget base class
abstract class OptimizedStatefulWidget extends StatefulWidget {
  const OptimizedStatefulWidget({super.key});
}

/// Optimized container that uses SizedBox when possible
class OptimizedContainer extends StatelessWidget {
  const OptimizedContainer({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.child,
  });

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // Use SizedBox for simple sizing without decoration
    if (decoration == null && padding == null && margin == null) {
      return SizedBox(
        width: width,
        height: height,
        child: child,
      );
    }

    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }
}

/// Optimized image widget with caching
class OptimizedImage extends StatelessWidget {
  const OptimizedImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      // Enable caching and optimize memory usage
      cacheWidth: width?.toInt(),
      cacheHeight: height?.toInt(),
      filterQuality: FilterQuality.medium,
    );
  }
}

/// Optimized list view with performance improvements
class OptimizedListView extends StatelessWidget {
  const OptimizedListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      scrollDirection: scrollDirection,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      // Performance optimizations
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      addSemanticIndexes: false,
      cacheExtent: 500.0, // Limit cache extent
    );
  }
}

/// Optimized card widget
class OptimizedCard extends StatelessWidget {
  const OptimizedCard({
    super.key,
    required this.child,
    this.margin,
    this.elevation = 2.0,
    this.borderRadius = 8.0,
  });

  final Widget child;
  final EdgeInsetsGeometry? margin;
  final double elevation;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: elevation * 2,
            offset: Offset(0, elevation),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Optimized button with repaint boundary
class OptimizedButton extends StatelessWidget {
  const OptimizedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
        ),
        child: child,
      ),
    );
  }
}

/// Optimized text widget with const constructor
class OptimizedText extends StatelessWidget {
  const OptimizedText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
