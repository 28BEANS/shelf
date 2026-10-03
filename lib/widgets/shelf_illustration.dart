import 'package:flutter/material.dart';

class ShelfIllustration extends StatefulWidget {
  const ShelfIllustration({super.key, this.height = 150});

  final double height;

  @override
  State<ShelfIllustration> createState() => _ShelfIllustrationState();
}

class _ShelfIllustrationState extends State<ShelfIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  Offset _tilt = Offset.zero;
  bool _pressed = false;
  bool? _reduceMotion;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (_reduceMotion == reduceMotion) return;
    _reduceMotion = reduceMotion;
    if (reduceMotion) {
      _entrance.value = 1;
      _tilt = Offset.zero;
      _pressed = false;
    } else if (_entrance.isDismissed) {
      _entrance.forward();
    }
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  void _updateTilt(Offset position, Size size, {bool pressed = false}) {
    if (_reduceMotion == true || size.isEmpty) return;
    final next = Offset(
      (position.dx / size.width * 2 - 1).clamp(-1, 1).toDouble(),
      (position.dy / size.height * 2 - 1).clamp(-1, 1).toDouble(),
    );
    if ((next - _tilt).distanceSquared < 0.002 && (!pressed || _pressed)) {
      return;
    }
    setState(() {
      _tilt = next;
      if (pressed) _pressed = true;
    });
  }

  void _resetTilt() {
    if (_tilt == Offset.zero && !_pressed) return;
    setState(() {
      _tilt = Offset.zero;
      _pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: widget.height,
    child: ClipRect(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          return MouseRegion(
            onHover: (event) => _updateTilt(event.localPosition, size),
            onExit: (_) => _resetTilt(),
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerDown: (event) =>
                  _updateTilt(event.localPosition, size, pressed: true),
              onPointerMove: (event) => _updateTilt(event.localPosition, size),
              onPointerUp: (_) => _resetTilt(),
              onPointerCancel: (_) => _resetTilt(),
              child: AnimatedBuilder(
                animation: _entrance,
                builder: (context, child) {
                  final progress = Curves.easeOutCubic.transform(
                    _entrance.value,
                  );
                  return Opacity(
                    opacity: progress,
                    child: Transform.translate(
                      offset: Offset(0, 10 * (1 - progress)),
                      child: child,
                    ),
                  );
                },
                child: Transform.translate(
                  offset: Offset(_tilt.dx * 18, _tilt.dy * 8),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(-_tilt.dy * 0.12)
                      ..rotateY(_tilt.dx * 0.14),
                    child: AnimatedScale(
                      scale: _pressed ? 1.08 : 1,
                      duration: _reduceMotion == true
                          ? Duration.zero
                          : const Duration(milliseconds: 120),
                      curve: Curves.easeOutCubic,
                      child: Transform.scale(
                        scale: 1.14,
                        child: Image.asset(
                          'assets/login/storage-diorama.png',
                          width: size.width,
                          height: size.height,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.medium,
                          semanticLabel:
                              '3D storage shelves with highlighted compartments',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
