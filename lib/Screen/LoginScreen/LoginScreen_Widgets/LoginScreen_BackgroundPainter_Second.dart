import 'package:flutter/material.dart';

class LoginScreenBackgroundPainterSecond extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.shader = LinearGradient(colors: [
      Colors.blue.shade300,
      Colors.deepPurple.shade100,
      Colors.deepPurple.shade300,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight)
        .createShader(Rect.fromLTRB(0.0, 0.0, size.width, size.height));
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(size.width, size.height * 0.88);
    path.quadraticBezierTo(
        size.width * 0.3, size.height * 0.85, 0, size.height * 0.58);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
