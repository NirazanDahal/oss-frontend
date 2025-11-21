import 'package:oss_frontend/core/utils/error_response_model.dart';

class CreateException implements Exception {
  final ErrorResponseModel error;

  CreateException(this.error);

  @override
  String toString() => error.error;
}

class UpdateException implements Exception {
  final ErrorResponseModel error;

  UpdateException(this.error);

  @override
  String toString() => error.error;
}

class DeleteException implements Exception {
  final ErrorResponseModel error;

  DeleteException(this.error);

  @override
  String toString() => error.error;
}

class FetchException implements Exception {
  final ErrorResponseModel error;

  FetchException(this.error);

  @override
  String toString() => error.error;
}
