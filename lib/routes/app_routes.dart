// lib/routes/app_routes.dart
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ione_office_intern/routes/route_constants.dart';

import '../views/account/views/account_view.dart';
import '../views/authentication/login_user/views/login_user_view.dart';
import '../views/home/views/home_view.dart';
import '../views/launch_screen/views/launch_screen_view.dart';
import '../views/sample/array_of_object_request/views/sample_array_of_object_request_view.dart';
import '../views/sample/sample_request_view.dart';
import '../views/sample/single_object_request/views/sample_single_object_request_view.dart';
import '../views/sample/single_object_with_nested_array/views/sample_single_object_with_nested_view.dart';

class AppRoutes {
  static List<GetPage> getPages = [
    GetPage(name: RouteConstants.userLogin, page: () => LoginUserView()),
    GetPage(name: RouteConstants.myAccount, page: () => AccountView()),
    GetPage(name: RouteConstants.launchScreen, page: () => LaunchScreenView()),
    GetPage(name: RouteConstants.home, page: () => HomeView()),
    GetPage(name: RouteConstants.sampleRequestView, page: () => SampleRequestView()),
    GetPage(name: RouteConstants.singleObjectWithNestedView, page: () => SampleSingleObjectWithNestedView()),
    GetPage(name: RouteConstants.singleObjectView, page: () => SampleSingleObjectRequestView()),
    GetPage(name: RouteConstants.arrayOfObjectView, page: () => SampleArrayOfObjectRequestView()),
  ];
}
