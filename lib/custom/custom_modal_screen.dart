import 'package:flutter/foundation.dart'; // To check for web
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/constant/colors.dart';
import '../utils/constant/enum_type.dart';
import '../utils/constant/fonts_style.dart';
import '../utils/utils.dart';

class CustomModalScreen extends StatefulWidget {
  final String? title;
  final Widget? content;
  final Color? backgroundColor;
  final double? height;
  final double? portraitHeight;

  const CustomModalScreen({
    Key? key,
    this.title,
    this.content,
    this.backgroundColor,
    this.height,
    this.portraitHeight,
  }) : super(key: key);

  @override
  _CustomModalScreenState createState() => _CustomModalScreenState();
}

class _CustomModalScreenState extends State<CustomModalScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Define the fade animation
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Determine height based on platform and orientation
    final modalHeight = widget.height ??
        (kIsWeb
            ? screenHeight * 0.6 // Web: Limit height to 60% of screen
            : isPortrait
                ? (widget.portraitHeight ??
                    screenHeight * 0.5) // Mobile Portrait
                : screenHeight); // Mobile Landscape

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.back(), // Close when tapping outside
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FadeTransition(
              opacity: _animation,
              child: Container(
                height: modalHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? Primitives.grey2,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildTopContainer(context, widget.title),
                      Expanded(child: widget.content ?? const SizedBox()),
                      // Content area
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopContainer(BuildContext context, String? title) {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 4,
                  width: 45,
                  color: Primitives.grey5,
                ),
                const SizedBox(height: 16),
                Text(
                  title ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: appFont,
                    fontWeight: bold,
                    color: TextColor.dark.color,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Primitives.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  getIconUrl(path: 'ic_close', type: ImageType.svg),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
