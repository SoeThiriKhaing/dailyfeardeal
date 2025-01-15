import 'package:dailyfairdeal/config/api_messages.dart';

class ApiErrorHandler {
  static void handleError(int statusCode) {
    switch (statusCode) {
      case 401:
        throw Exception(ApiMessages.unauthorized);
      case 500:
        throw Exception(ApiMessages.serverError);
      default:
        throw Exception(ApiMessages.failedToLoad);
    }
  }
}
