import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLoadingSpinner extends StatefulWidget {
  final double height;
  final double width;

  const CustomLoadingSpinner({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<CustomLoadingSpinner> createState() => _CustomLoadingSpinnerState();
}

class _CustomLoadingSpinnerState extends State<CustomLoadingSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _rotation;

  late Color _spinnerColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _scale = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.6, end: 0.8), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 0.8, end: 0.6), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Use didChangeDependencies, as it's the safe place
    // to access Theme.of(context) after initState
    _spinnerColor = Colors.black;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double unit = widget.height / 2; // scale relative to widget size

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: RotationTransition(
        turns: _rotation,
        child: Stack(
          alignment: Alignment.center,
          children: [
            //right
            Positioned(
              bottom: unit * 0.46,
              right: unit * 0.34,
              child: ScaleTransition(
                scale: _scale,
                child: SvgPicture.asset(
                  'asset/svg/Rectangle 1.svg',
                  height: unit * 0.8,
                  width: unit * 0.8,
                  colorFilter: ColorFilter.mode(_spinnerColor, BlendMode.srcIn),
                ),
              ),
            ),
            //left
            Positioned(
              bottom: unit * 0.55,
              left: unit * 0.3,
              child: ScaleTransition(
                scale: _scale,
                child: SvgPicture.asset(
                  'asset/svg/Rectangle 2.svg',
                  height: unit * 0.8,
                  width: unit * 0.8,
                  colorFilter: ColorFilter.mode(_spinnerColor, BlendMode.srcIn),
                ),
              ),
            ),
            //top
            Positioned(
              top: unit * 0.2,
              left: unit * 0.5,
              child: ScaleTransition(
                scale: _scale,
                child: SvgPicture.asset(
                  'asset/svg/Rectangle 3.svg',
                  height: unit * 0.8,
                  width: unit * 0.8,
                  colorFilter: ColorFilter.mode(_spinnerColor, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
