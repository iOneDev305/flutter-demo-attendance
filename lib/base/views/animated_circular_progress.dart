import 'package:flutter/material.dart';

import '../../utils/constant/colors.dart';

class AnimatedCircularProgress extends StatefulWidget {
  final double value;

  const AnimatedCircularProgress({Key? key, required this.value})
      : super(key: key);

  @override
  _AnimatedCircularProgressState createState() =>
      _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress>
    with AutomaticKeepAliveClientMixin {
  late double _previousValue;

  @override
  void initState() {
    super.initState();
    _previousValue = 0.0;
  }

  @override
  void didUpdateWidget(covariant AnimatedCircularProgress oldWidget) {
    if (widget.value != oldWidget.value) {
      setState(() {
        _previousValue = oldWidget.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // This is required for AutomaticKeepAliveClientMixin
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: _previousValue,
        end: widget.value,
      ),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return CircularProgressIndicator(
          value: value,
          backgroundColor: LineColor.lineGrey.color,
          valueColor: AlwaysStoppedAnimation(LineColor.lineBlue.color),
          strokeWidth: 8,
          strokeCap: StrokeCap.round,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
