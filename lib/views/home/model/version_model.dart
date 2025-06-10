class VersionModel {
  final String appId;
  final String version;

  VersionModel({
    required this.appId,
    required this.version,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) {
    return VersionModel(
      appId: json['app_id'] ?? '',
      version: json['version'] ?? '',
    );
  }
}
