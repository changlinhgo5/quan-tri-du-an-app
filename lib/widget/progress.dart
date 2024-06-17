import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressIndicatorApp extends StatefulWidget {
  const ProgressIndicatorApp({
    super.key,
    required this.progress,
    this.height = 8,
    this.color,
    this.name,
    this.showSuffixProgress = false,
    this.timeRemain,
  });
  final double progress;
  final Widget? timeRemain;

  final double height;
  final Color? color;
  final String? name;
  final bool showSuffixProgress;
  @override
  State<ProgressIndicatorApp> createState() => _ProgressIndicatorAppState();
}

class _ProgressIndicatorAppState extends State<ProgressIndicatorApp>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    animation = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ProgressIndicatorApp oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      animation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(controller);
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.name != null)
              Text(
                widget.name!,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            if (widget.showSuffixProgress)
              widget.timeRemain ??
                  Text(
                    widget.progress.toString(),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
          ],
        ),
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: animation.value,
              semanticsLabel: 'Linear progress indicator',
              minHeight: widget.height,
              borderRadius: BorderRadius.circular(20),
              color: widget.color,
              backgroundColor: Colors.black12.withOpacity(0.1),
            );
          },
        )
      ],
    );
  }
}
