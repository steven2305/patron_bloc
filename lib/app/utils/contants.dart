import 'package:dio/dio.dart';

const String REPO_URL = 'https://prueba-bloc-default-rtdb.firebaseio.com';

final BaseOptions baseOptions = BaseOptions(
  baseUrl: '$REPO_URL',
  validateStatus: (status) => status < 500,
  responseType: ResponseType.json,
  contentType: 'application/json',
);

final Map<String, dynamic> noInternetMessage = {
  'ok': false,
  'message': 'no-wifi'
};

final Map<String, dynamic> internalErrorMessage = {
  'ok': false,
  'message': 'internal'
};

enum RequestStatus {
  loading,
  done,
  error
}
