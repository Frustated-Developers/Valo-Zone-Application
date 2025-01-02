import 'package:flutter/material.dart';
import 'package:valo_zone/utils/AppColors.dart';

class SearchBox extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final TextStyle textStyle;
  final double cornerCut;
  final double radius;
  final ValueChanged<String>? onChanged;

  const SearchBox({
    Key? key,
    this.height = 65,
    this.width = 300,
    this.backgroundColor = const Color(0xFF1B242E),
    this.borderColor = AppColors.searchBackground,
    this.borderWidth = 3,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
    ),
    this.cornerCut = 15.0,
    this.radius = 8.0,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
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
          child: TextFormField(
            style: textStyle,
            onChanged: onChanged,
            decoration: const InputDecoration(
              hintText: 'Search Agent..',
              hintStyle: TextStyle(
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
                color: Colors.grey,
                fontSize: 20,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonClipper extends CustomClipper<Path> {
  final double cornerCut;
  final double radius;

  const CustomButtonClipper({
    this.cornerCut = 15.0,
    this.radius = 8.0,
  });

  @override
  Path getClip(Size size) => _generatePath(size);

  Path _generatePath(Size size) {
    final path = Path();
    path.moveTo(cornerCut, 0);
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: Radius.circular(radius),
    );
    path.lineTo(size.width, size.height - cornerCut);
    path.lineTo(size.width - cornerCut, size.height);
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: Radius.circular(radius),
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

  const BorderPainter({
    this.borderColor = AppColors.searchBackground,
    this.borderWidth = 3,
    this.cornerCut = 15.0,
    this.radius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(_generatePath(size), paint);
  }

  Path _generatePath(Size size) {
    return CustomButtonClipper(
      cornerCut: cornerCut,
      radius: radius,
    )._generatePath(size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
