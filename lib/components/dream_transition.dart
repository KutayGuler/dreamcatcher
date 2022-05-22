import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DreamTransition extends StatefulWidget {
  const DreamTransition({Key? key}) : super(key: key);

  @override
  State<DreamTransition> createState() => _DreamTransitionState();
}

class _DreamTransitionState extends State<DreamTransition>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 12),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  bool clicked = false;

  Offset pos = Offset(0, 0);

  onTapDown(TapDownDetails details) {
    setState(() {
      pos = details.globalPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (TapDownDetails details) => onTapDown(details),
        onTap: () {
          // Navigator.
          setState(() {
            // _controller.forward();

            clicked = !clicked;
            if (clicked) _controller.forward();
            if (!clicked) _controller.reset();
          });
        },
        child: clicked
            ? ScaleTransition(
                scale: _animation,
                child: CustomPaint(foregroundPainter: ShapePainter(pos)))
            : Container(),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  Offset pos;

  ShapePainter(this.pos);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5.w
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(pos, size.height * 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
