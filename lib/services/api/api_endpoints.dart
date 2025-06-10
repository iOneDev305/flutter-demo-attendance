class ApiEndpoints {
  // User-related endpoints
  static const String postUserLogin = '/api/auth/login';
  static const String postUserLogout = '/staffs/logout';
  static const String getMyAccount = '/staffs/myaccount';
  static const String postFeedback = '/staffs/feedback';
  static const String getUserListByDepartment = '/staffs/bydepartment/index';

  // Department-related endpoints
  static const String getDepartment = '/staffs/department/index';

  // E-Leave related endpoints
  static const String getELeave = '/eleaves/index';
  static const String getELeaveCalculate = '/eleaves/calculate';
  static const String getELeaveView = '/eleaves/view';
  static const String postELeaveApprove = '/eleaves/approve';
  static const String getMyBalance = '/eleaves/mybalance';
  static const String getELeaveType = '/eleaves/type';
  static const String postELeaveCreate = '/eleaves/create';

  // Version App
  static const String getAppVersion = '/backends/apps/version';


  // Attendances
  static const String postAttendancesCreate = '/attendances/create';
  static const String getAttendancesIndex = '/attendances/index';
  static const String getAttendancesMy = '/attendances/my';

  // Notification
  static const String postUpdatePlayerId = '/staffs/updateplayerid';
  static const String getNotificationsIndex = '/notifications/index';
  static const String getNotificationsView = '/notifications/view';
  static const String postNotificationsRead = '/notifications/read';



}
