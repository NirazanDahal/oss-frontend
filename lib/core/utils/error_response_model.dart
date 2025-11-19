class ErrorResponseModel {
  final bool success;
  final String error;

  ErrorResponseModel({required this.success, required this.error});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      success: json['success'] ?? false,
      error: json['error'] ?? '',
    );
  }
}
