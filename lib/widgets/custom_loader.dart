import 'package:flutter/material.dart';

class PouringHourGlassRefined extends StatefulWidget {
  final double size;
  final Color color;

  const PouringHourGlassRefined({
    Key? key,
    this.size = 50.0,
    this.color = Colors.indigo,
  }) : super(key: key);

  @override
  _PouringHourGlassRefinedState createState() => _PouringHourGlassRefinedState();
}

class _PouringHourGlassRefinedState extends State<PouringHourGlassRefined> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _rotationAnim = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: AnimatedBuilder(
        animation: _rotationAnim,
        builder: (_, child) {
          return Transform.rotate(
            angle: _rotationAnim.value * 6.28318, // 2 * pi radians
            child: child,
          );
        },
        child: Icon(
          Icons.hourglass_bottom,
          size: widget.size,
          color: widget.color,
        ),
      ),
    );
  }
}
