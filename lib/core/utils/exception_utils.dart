import 'package:oss_frontend/core/utils/error_response_model.dart';

class CreateException implements Exception {
  final ErrorResponseModel error;

  CreateException(this.error);

  @override
  String toString() => error.error;
}
