class CreateErrorResponse {
  final bool success;
  final String error;

  CreateErrorResponse({required this.success, required this.error});

  factory CreateErrorResponse.fromJson(Map<String, dynamic> json) {
    return CreateErrorResponse(
      success: json['success'] ?? false,
      error: json['error'] ?? '',
    );
  }
}
