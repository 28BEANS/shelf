import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A looping loading illustration built from the supplied Shelf artwork.
///
/// Use [label] for a visible status message, or omit it for the artwork alone.
/// Motion stops on devices that request reduced animation.
class ShelfLoadingAnimation extends StatefulWidget {
  const ShelfLoadingAnimation({super.key, this.size = 218, this.label});

  final double size;
  final String? label;

  @override
  State<ShelfLoadingAnimation> createState() => _ShelfLoadingAnimationState();
}

class _ShelfLoadingAnimationState extends State<ShelfLoadingAnimation>
    with SingleTickerProviderStateMixin {
  static const _cycleSeconds = 3.8;
  late final AnimationController _controller;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion == _reduceMotion) return;
    _reduceMotion = reduceMotion;
    if (reduceMotion) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.label ?? 'Loading Shelf',
      liveRegion: true,
      child: ExcludeSemantics(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: widget.size,
              height: widget.size * 210 / 194,
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: 194,
                  height: 210,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) => _artwork(
                      _reduceMotion ? 2.15 : _controller.value * _cycleSeconds,
                    ),
                  ),
                ),
              ),
            ),
            if (widget.label != null) ...[
              const SizedBox(height: 16),
              Text(
                widget.label!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _artwork(double seconds) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(child: CustomPaint(painter: _ShelfPainter(seconds))),
        for (var index = 0; index < _objects.length; index++)
          _object(_objects[index], index, seconds),
      ],
    );
  }

  Widget _object(_ObjectSpec item, int index, double seconds) {
    final arrival = _progress(
      seconds,
      item.arrival,
      item.arrival + 0.54,
      Curves.easeOutBack,
    );
    final departure = _progress(
      seconds,
      item.departure,
      item.departure + 0.32,
      Curves.easeInCubic,
    );
    final opacity =
        _progress(seconds, item.arrival, item.arrival + 0.22, Curves.easeOut) *
        (1 -
            _progress(
              seconds,
              item.departure,
              item.departure + 0.27,
              Curves.easeIn,
            ));
    final idle =
        _progress(seconds, 1.55, 1.82, Curves.easeInOut) *
        (1 - _progress(seconds, 2.48, 2.78, Curves.easeInOut));
    final float =
        math.sin(seconds * math.pi * 2 / 1.42 + index * 0.85) * 1.35 * idle;

    return Positioned(
      left: item.x - 16,
      top: item.y - 8,
      width: item.width + 32,
      height: item.height + 32,
      child: Transform.translate(
        offset: Offset(0, 19 * (1 - arrival) - 13 * departure + float),
        child: Transform.rotate(
          angle:
              (index.isEven ? -1 : 1) *
              (0.035 * (1 - arrival) + 0.045 * departure),
          child: Transform.scale(
            scale: 0.84 + 0.16 * arrival - 0.06 * departure,
            child: Opacity(
              opacity: opacity.clamp(0.0, 1.0),
              child: Image.asset(
                'assets/shelf_loader/${item.asset}.png',
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

double _progress(double time, double start, double end, Curve curve) {
  return curve.transform(((time - start) / (end - start)).clamp(0.0, 1.0));
}

class _ObjectSpec {
  const _ObjectSpec(
    this.asset,
    this.x,
    this.y,
    this.width,
    this.height,
    this.arrival,
    this.departure,
  );

  final String asset;
  final double x;
  final double y;
  final double width;
  final double height;
  final double arrival;
  final double departure;
}

// Coordinates are from the 194 × 210 source graphic.
const _objects = <_ObjectSpec>[
  _ObjectSpec('task_lamp', 38, 72, 53, 46, 0.84, 2.79),
  _ObjectSpec('pitcher', 114, 22, 32, 24, 1.32, 2.55),
  _ObjectSpec('storage_box', 97, 84, 66, 37, 1.00, 2.72),
  _ObjectSpec('plant', 37, 8, 56, 45, 1.16, 2.62),
  _ObjectSpec('radio', 95, 141, 68, 45, 0.70, 2.88),
  _ObjectSpec('table_lamp', 28, 142, 64, 43, 0.54, 2.95),
];

class _ShelfPainter extends CustomPainter {
  const _ShelfPainter(this.seconds);

  final double seconds;

  @override
  void paint(Canvas canvas, Size size) {
    final panelOpacity =
        _progress(seconds, 0.12, 0.68, Curves.easeOutCubic) *
        (1 - _progress(seconds, 3.08, 3.51, Curves.easeInCubic));

    // The two cabinet sides sit behind the three floating shelf planes.
    _polygon(
      canvas,
      const [
        Offset(149, 105),
        Offset(193, 118),
        Offset(193, 191),
        Offset(149, 178),
      ],
      const Color(0xFFD9D9D9),
      panelOpacity,
    );
    _polygon(
      canvas,
      const [Offset(0, 37), Offset(44, 50), Offset(44, 123), Offset(0, 110)],
      const Color(0xFFDDE3EC),
      panelOpacity,
    );
    _polygon(
      canvas,
      const [Offset(40, 49), Offset(44, 50), Offset(44, 123), Offset(40, 122)],
      const Color(0xFFC2CDDB),
      panelOpacity,
    );

    _shelf(
      canvas,
      173,
      0.04,
      3.24,
      const Color(0xFF9DF6BE),
      const Color(0xFF73F2A1),
      const Color(0xFF41F182),
    );
    _shelf(
      canvas,
      105,
      0.17,
      3.15,
      const Color(0xFFC4DAFA),
      const Color(0xFF9ABFF6),
      const Color(0xFF69A1F5),
    );
    _shelf(
      canvas,
      37,
      0.30,
      3.06,
      const Color(0xFFD4FE00),
      const Color(0xFFA5C600),
      const Color(0xFF7B9300),
    );
  }

  void _shelf(
    Canvas canvas,
    double y,
    double arrival,
    double departure,
    Color top,
    Color edge,
    Color side,
  ) {
    final enter = _progress(
      seconds,
      arrival,
      arrival + 0.57,
      Curves.easeOutCubic,
    );
    final exit = _progress(
      seconds,
      departure,
      departure + 0.34,
      Curves.easeInCubic,
    );
    final opacity = enter * (1 - exit);
    canvas.save();
    canvas.translate(0, 12 * (1 - enter) - 9 * exit);

    _polygon(
      canvas,
      [Offset(0, y), Offset(149, y), Offset(149, y + 5), Offset(0, y + 5)],
      edge,
      opacity,
    );
    _polygon(
      canvas,
      [Offset(0, y), Offset(44, y + 13), Offset(44, y + 18), Offset(0, y + 5)],
      side,
      opacity,
    );
    _polygon(
      canvas,
      [
        Offset(149, y),
        Offset(193, y + 13),
        Offset(193, y + 18),
        Offset(149, y + 5),
      ],
      side,
      opacity,
    );
    _polygon(
      canvas,
      [
        Offset(44, y + 13),
        Offset(193, y + 13),
        Offset(193, y + 18),
        Offset(44, y + 18),
      ],
      edge,
      opacity,
    );
    _polygon(
      canvas,
      [Offset(0, y), Offset(149, y), Offset(193, y + 13), Offset(44, y + 13)],
      top,
      opacity,
    );
    canvas.restore();
  }

  void _polygon(
    Canvas canvas,
    List<Offset> points,
    Color color,
    double opacity,
  ) {
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    path.close();
    canvas.drawPath(
      path,
      Paint()..color = color.withValues(alpha: opacity.clamp(0.0, 1.0)),
    );
  }

  @override
  bool shouldRepaint(covariant _ShelfPainter oldDelegate) =>
      oldDelegate.seconds != seconds;
}
