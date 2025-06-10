import 'package:flutter/material.dart';

extension NavigatorPopExtension on BuildContext {
  void pop([dynamic result]) {
    Navigator.of(this).pop(result);
  }
}
