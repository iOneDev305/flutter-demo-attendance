

class ApiModel {
  final int code;
  final String? msg;
  final String? time;
  final dynamic data; // Keep as dynamic to handle different data types

  ApiModel({
    required this.code,
    this.msg,
    this.time,
    this.data,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      code: json['code'] as int,
      msg: json['msg'] as String?,
      time: json['time'] as String?,
      data: json['data'], // Keep as dynamic
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'time': time,
      'data': data,
    };
  }
}
