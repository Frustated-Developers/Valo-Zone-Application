import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final TextStyle textStyle;
  final double cornerCut;
  final double radius;
  final VoidCallback? onPressed; // Added onPressed parameter

  const CustomButton({
    Key? key,
    required this.text,
    this.height = 65,
    this.width = 300,
    this.backgroundColor = const Color(0xFF1B242E),
    this.borderColor = Colors.white,
    this.borderWidth = 3,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
    ),
    this.cornerCut = 15.0,
    this.radius = 8.0,
    this.onPressed, // Initialize onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Trigger onPressed when tapped
      child: CustomPaint(
        painter: BorderPainter(
          borderColor: borderColor,
          borderWidth: borderWidth,
          cornerCut: cornerCut,
          radius: radius,
        ),
        child: ClipPath(
          clipper: CustomButtonClipper(cornerCut: cornerCut, radius: radius),
          child: Container(
            height: height,
            width: width,
            color: backgroundColor,
            alignment: Alignment.center,
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Clipper with corner cut and radius parameters
class CustomButtonClipper extends CustomClipper<Path> {
  final double cornerCut;
  final double radius;

  CustomButtonClipper({this.cornerCut = 15.0, this.radius = 8.0});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(cornerCut, 0);
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(size.width, size.height - cornerCut);
    path.lineTo(size.width - cornerCut, size.height);
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(0, cornerCut);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double cornerCut;
  final double radius;

  BorderPainter({
    this.borderColor = Colors.white,
    this.borderWidth = 3,
    this.cornerCut = 15.0,
    this.radius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(cornerCut, 0);
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(size.width, size.height - cornerCut);
    path.lineTo(size.width - cornerCut, size.height);
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(0, cornerCut);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
