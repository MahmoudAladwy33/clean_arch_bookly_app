import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errMessage: 'Connection Timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errMessage: 'Send Timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMessage: 'Receive Timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: 'Bad Certificate with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errMessage: 'Request To ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure(errMessage: 'No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure(errMessage: 'Oops there was an Error , try again');
      default:
        return ServerFailure(errMessage: 'Oops there was an Error , try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
          errMessage: response['error']['message'] ?? 'Authentication error');
    } else if (statusCode == 404) {
      return ServerFailure(
          errMessage: 'Your request not found ,Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure(
          errMessage: 'Internal server Error , please try later!');
    } else {
      return ServerFailure(errMessage: 'Oops there was an Error , try again');
    }
  }
}
