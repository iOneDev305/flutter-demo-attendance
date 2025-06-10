import 'package:flutter/cupertino.dart';

class FadeTransitionBottomSheet extends StatefulWidget {
  final Widget child;

  const FadeTransitionBottomSheet({required this.child, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FadeTransitionBottomSheetState createState() =>
      _FadeTransitionBottomSheetState();
}

class _FadeTransitionBottomSheetState extends State<FadeTransitionBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Define the animation that changes from 0.0 to 1.0
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start the animation when the bottom sheet is built
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
