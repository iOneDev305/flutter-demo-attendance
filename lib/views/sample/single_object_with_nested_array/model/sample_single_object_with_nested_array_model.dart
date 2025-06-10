class SampleModel {
  final int userId;
  final String username;
  final String profilePhoto;
  final String userDepartment;
  final List<SampleContentList> myAttendanceList;

  SampleModel({
    required this.userId,
    required this.username,
    required this.profilePhoto,
    required this.userDepartment,
    required this.myAttendanceList,
  });

  factory SampleModel.fromJson(Map<String, dynamic> json) {
    return SampleModel(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? '',
      profilePhoto: json['profile_photo'] ?? '',
      userDepartment: json['user_department'] ?? '',
      myAttendanceList: SampleContentList.fromJsonList(json['lists']),
    );
  }
}

class SampleContentList {
  final int id;
  final String inLabel;
  final String outLabel;
  final String checkDate;
  final String inTime;
  final String outTime;
  final dynamic inOnTime;
  final dynamic outOnTime;
  final String inStatusLabel;
  final String outStatusLabel;
  final String inColor;
  final String outColor;

  SampleContentList({
    required this.id,
    required this.inLabel,
    required this.outLabel,
    required this.checkDate,
    required this.inTime,
    required this.outTime,
    required this.inOnTime,
    required this.outOnTime,
    required this.inStatusLabel,
    required this.outStatusLabel,
    required this.inColor,
    required this.outColor,
  });

  factory SampleContentList.fromJson(Map<String, dynamic> json) {
    return SampleContentList(
      id: json['id'] ?? 0,
      inLabel: json['in_label'] ?? "",
      outLabel: json['out_label'] ?? "",
      checkDate: json['check_date'] ?? "",
      inTime: json['in_time'] ?? "",
      outTime: json['out_time'] ?? "",
      inOnTime: json['in_on_time'] ?? "",
      outOnTime: json['out_on_time'] ?? "",
      inStatusLabel: json['in_status_label'] ?? "",
      outStatusLabel: json['out_status_label'] ?? "",
      inColor: json['in_color'] ?? "",
      outColor: json['out_color'] ?? "",
    );
  }

  static List<SampleContentList> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .map((json) => SampleContentList.fromJson(json))
        .toList();
  }
}
