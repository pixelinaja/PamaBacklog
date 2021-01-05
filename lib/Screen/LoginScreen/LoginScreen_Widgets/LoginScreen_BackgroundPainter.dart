import 'package:flutter/material.dart';

class LoginScreenBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.shader = LinearGradient(colors: [
      Colors.blueGrey.shade100,
      Colors.blueGrey.shade50,
      Colors.blueGrey.shade100,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight)
        .createShader(Rect.fromLTRB(0.0, 0.0, size.width, size.height));

    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(size.width, size.height * 0.93);
    path.quadraticBezierTo(
        size.width * 0.3, size.height * 0.88, 0, size.height * 0.6);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
