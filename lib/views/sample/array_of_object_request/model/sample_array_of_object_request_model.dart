class SampleArrayOfObjectRequestModel {
  final int id;
  final String name;

  SampleArrayOfObjectRequestModel({
    required this.id,
    required this.name,
  });

  factory SampleArrayOfObjectRequestModel.fromJson(Map<String, dynamic> json) {
    return SampleArrayOfObjectRequestModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
    );
  }

  static List<SampleArrayOfObjectRequestModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SampleArrayOfObjectRequestModel.fromJson(json)).toList();
  }
}
