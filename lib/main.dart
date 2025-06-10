import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:ione_office_intern/routes/route_constants.dart';
import 'package:ione_office_intern/services/language/localization_service.dart';
import 'package:ione_office_intern/utils/connectivity/connectivity_service.dart';

import 'routes/app_routes.dart';

void main() async {
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize LocalizationService and register it with GetX
  final localizationService = await LocalizationService().init();
  Get.put(localizationService);

  Get.put(ConnectivityService());

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocalizationService localizationService =
        Get.find<LocalizationService>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteConstants.launchScreen,
      getPages: AppRoutes.getPages,
      locale: Locale(localizationService.locale),
      translations: localizationService,
      fallbackLocale: const Locale('en'),
      theme: ThemeData.light(),
      darkTheme: null,
      themeMode: ThemeMode.light,
    );
  }
}
