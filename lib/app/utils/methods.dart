import 'dart:io';

import 'package:dio/dio.dart';


bool shouldRetry(DioError err) =>
    err.type == DioErrorType.DEFAULT && 
    err.error != null && 
    err.error is SocketException;


String translateMessage(String message, [bool google = false]) {

  return message;
}

