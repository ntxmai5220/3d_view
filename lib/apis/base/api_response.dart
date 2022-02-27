class APIResponse {
  int? code;
  String? message;
  dynamic data;
  APIResponse.address({
    this.code,
    this.message,
    required this.data,
  });


  factory APIResponse.fromJson(Map<String, dynamic> json) => APIResponse.address(
      code: json['code'],
      message: json['message'],
      data: json['data']
      );

  // Map<String, dynamic> toObject() {
  //   return Map<String, dynamic>.from(data);
  // }

  List<Map<String, dynamic>> toListAddress() {
    return List<Map<String, dynamic>>.from(data);
  }
}
