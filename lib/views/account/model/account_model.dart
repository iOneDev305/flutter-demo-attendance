class AccountModel {
  final int id;
  final String employeeId;
  final String username;
  final String profilePhoto;
  final String email;
  final String phoneNumber;
  final String position;
  final String departmentId;
  final String department;
  final String serviceGrade;
  final num annualLeave;
  final String dateJoined;
  final String appToken;
  final String hodEmail;
  final String gender;
  final String genderLabel;
  final String isActive;
  final String isActiveLabel;
  final int locationId;
  final int notificationCount;

  AccountModel({
    required this.id,
    required this.employeeId,
    required this.username,
    required this.profilePhoto,
    required this.email,
    required this.phoneNumber,
    required this.position,
    required this.departmentId,
    required this.department,
    required this.serviceGrade,
    required this.annualLeave,
    required this.dateJoined,
    required this.appToken,
    required this.hodEmail,
    required this.gender,
    required this.genderLabel,
    required this.isActive,
    required this.isActiveLabel,
    required this.locationId,
    required this.notificationCount,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] ?? 0,
      employeeId: json['employee_id'] ?? '',
      username: json['username'] ?? '',
      profilePhoto: json['profile_photo'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      position: json['position'] ?? '',
      departmentId: json['department_id'] ?? '',
      department: json['department'] ?? '',
      serviceGrade: json['service_grade'] ?? '',
      annualLeave: json['annual_leave'] ?? 0,
      dateJoined: json['date_joined'] ?? '',
      appToken: json['app_token'] ?? '',
      hodEmail: json['hod_email'] ?? '',
      gender: json['gender'] ?? '',
      genderLabel: json['gender_label'] ?? '',
      isActive: json['is_active'] ?? '',
      isActiveLabel: json['is_active_label'] ?? '',
      locationId: json['location_id'] ?? 0,
      notificationCount: json['notification_count'] ?? 0,
    );
  }
}
