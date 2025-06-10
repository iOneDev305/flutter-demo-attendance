// future_helpers.dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom/custom_network_image.dart';
import '../services/language/localization_service.dart';

Widget futureText(Future<String?> future, TextStyle style,
    {String fallback = 'Loading...'}) {
  return FutureBuilder<String?>(
    future: future,
    builder: (context, snapshot) => Text(
      snapshot.data ?? fallback,
      style: style,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget futureImage(Future<String?> future, {double size = 48}) {
  return FutureBuilder<String?>(
    future: future,
    builder: (context, snapshot) => CustomNetworkImage(
      width: size,
      height: size,
      imageUrl: snapshot.data ?? '',
      placeholderImage: 'assets/icons/placeholder_logo.png',
      borderRadius: 48,
    ),
  );
}

// Function to get the font family based on the current locale
String currentAppFont() {
  final localizationService = Get.find<LocalizationService>();
  return localizationService.currentLocale == 'km'
      ? 'KhmerOSBattambang'
      : 'OpenSans';
}

Widget errorWidget(controller) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 50.0,
          ),
          const SizedBox(height: 10.0),
          Text(
            'error_occurred'.tr,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(
            controller.errorMessage.value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    ),
  );
}
