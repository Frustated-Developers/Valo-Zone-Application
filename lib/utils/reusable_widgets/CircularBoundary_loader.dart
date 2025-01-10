import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/reusable_widgets/RotateAnimation.dart';

class BallCircleRotateLoading extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  BallCircleRotateLoading({
    required this.color,
    this.width = 40,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: RotateAnimation(
        child: SvgPicture.asset(
          AssetPath.iconBallCircleLoading,
          color: color,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
