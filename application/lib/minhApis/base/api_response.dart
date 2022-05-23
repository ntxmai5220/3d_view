class APIResponse {
  int? code;
  String message;
  dynamic data;

  APIResponse.address({
    this.code,
    required this.message,
    required this.data,
  });

  APIResponse.app(
      {required this.data, this.message = 'Đã xảy ra lỗi vui lòng thử lại'});

  factory APIResponse.fromJson(Map<String, dynamic> json) =>
      APIResponse.address(
        code: json['code'],
        message: json['message'] ?? '',
        data: json['data'],
      );

  factory APIResponse.auth(Map<String, dynamic> json) => APIResponse.app(
        data: json,
      );

  factory APIResponse.fromAppJson(Map<String, dynamic> json) => APIResponse.app(
        data: json['result'],
        message: json['error'] ?? '',
      );

  List<Map<String, dynamic>> toListAddress() {
    return List<Map<String, dynamic>>.from(data);
  }

  Map<String, dynamic> toObject() {
    return Map<String, dynamic>.from(data['object']);
  }

  List<Map<String, dynamic>> toList() {
    return List<Map<String, dynamic>>.from(data['list']);
  }
}
