import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [_PurpleBox(), const _HeaderIcon(), child],
        ));
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(
          Icons.person_pin_circle,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      transform: Matrix4.identity()..rotateZ(-30 * 3.1415927 / 180),
      decoration: _purpleBackground(),
      child: Stack(
        children: const [
          Positioned(top: 90, left: 30, child: _Triangle(angulo: 100)),
          Positioned(top: 200, left: 190, child: _Triangle(angulo: 51)),
          Positioned(top: 600, left: 100, child: _Triangle(angulo: 53)),
          Positioned(bottom: -50, left: 10, child: _Triangle(angulo: 30)),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
      gradient: LinearGradient(colors: [Colors.blueGrey, Colors.blueAccent]));
}

class _Triangle extends StatelessWidget {
  final double angulo;
  // ignore: unused_element
  const _Triangle({super.key, required this.angulo});

  @override
  Widget build(BuildContext context) {
    return Container(
        transform: Matrix4.identity()..rotateZ(angulo),
        child:
            CustomPaint(size: const Size(100, 100), painter: DrawTriangle()));
  }
}

class DrawTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(
        path, Paint()..color = const Color.fromRGBO(255, 255, 255, 0.05));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
