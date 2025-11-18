import 'package:oss_frontend/core/utils/error_response_model.dart';

class CreateException implements Exception {
  final CreateErrorResponse error;

  CreateException(this.error);

  @override
  String toString() => error.error;
}
