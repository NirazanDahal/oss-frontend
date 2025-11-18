class RegisterErrorResponseModel {
  final bool success;
  final String error;

  RegisterErrorResponseModel({required this.success, required this.error});

  factory RegisterErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterErrorResponseModel(
      success: json['success'] ?? false,
      error: json['error'] ?? "Error registering user",
    );
  }
}
