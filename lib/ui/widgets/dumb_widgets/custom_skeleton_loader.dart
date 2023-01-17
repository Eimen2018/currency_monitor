// ignore_for_file: library_private_types_in_public_api

import 'package:currency_monitor/ui/common/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSkeletonLoader extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final Color startColor;
  final Color endColor;
  final Duration duration;
  const CustomSkeletonLoader({
    Key? key,
    required this.child,
    required this.isLoading,
    this.duration = const Duration(seconds: 1),
    this.startColor = kcVeryLightGrey,
    this.endColor = kcMediumGrey,
  }) : super(key: key);

  @override
  _CustomSkeletonLoaderState createState() => _CustomSkeletonLoaderState();
}

class _CustomSkeletonLoaderState extends State<CustomSkeletonLoader>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> animationOne;
  late Animation<Color?> animationTwo;

  Widget? _initialWidget;
  bool _transitionToNewWidget = false;
  bool _dispose = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Store the loading widget we first constructed with
    _initialWidget ??= widget.child;

    animationOne = ColorTween(begin: widget.startColor, end: widget.endColor)
        .animate(_controller);
    animationTwo = ColorTween(begin: widget.endColor, end: widget.startColor)
        .animate(_controller);

    _controller.forward();

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (_controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if it's updated
    if (widget.child != _initialWidget && widget.isLoading) {
      // Indicate that we want to transition to a new widget

      _transitionToNewWidget = true;

      _initialWidget = widget.child;

      // Since the ShaderMask will still be rendered BUT the size
      // has now updated to match the actual data.
      // We will use a delayed future to only fade out the shader mask
      // a few milliseconds after we have received the actual widget.
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        if (!_dispose) {
          setState(() {
            _transitionToNewWidget = false;
          });
        }
      });
    }

    return IgnorePointer(
      ignoring: widget.isLoading,
      child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          // We only want to show this if the widget is loading OR if the widget is busy with the transition.
          child: widget.isLoading || _transitionToNewWidget
              ? AnimatedSize(
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOut,
                  child: ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (rect) {
                      return LinearGradient(colors: [
                        animationOne.value!,
                        animationTwo.value!,
                      ]).createShader(rect);
                    },
                    child: CustomPaint(
                      foregroundPainter: RectangleFillPainter(),
                      child: widget.child,
                    ),
                  ),
                )
              : widget.child),
    );
  }

  @override
  void dispose() {
    _dispose = true;
    _controller.dispose();
    super.dispose();
  }
}

class RectangleFillPainter extends CustomPainter {
  bool hasPainted = true;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(0.0),
      ),
      Paint()..color = Colors.grey,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (!hasPainted) {
      hasPainted = true;
      return true;
    }
    return false;
  }
}
