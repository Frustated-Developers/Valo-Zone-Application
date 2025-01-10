import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class RotateAnimation extends StatefulWidget {
  final Widget child;

  RotateAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _RotateAnimationState createState() => _RotateAnimationState();
}

class _RotateAnimationState extends State<RotateAnimation> {
  double _currentAngle = 0.0;
  late Timer _timerAnimation;

  @override
  void initState() {
    super.initState();

    _timerAnimation = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (mounted)
        setState(() {
          _currentAngle += 6.0;
          if (_currentAngle >= 360.0) {
            _currentAngle -= 360.0;
          }
        });
    });
  }

  @override
  void dispose() {
    _timerAnimation?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _currentAngle * (math.pi / 180),
      child: widget.child,
    );
  }
}
