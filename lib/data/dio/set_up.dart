import 'package:dio/dio.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

const _huggingFaceApiToken = 'my_token';

void setUpDio(Dio dio) {
  dio.options.baseUrl = 'https://huggingface.co/api/';
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);

  dio.options.headers['Authorization'] = 'Bearer $_huggingFaceApiToken';

  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printResponseData: true,
        printRequestHeaders: true,
      ),
    ),
  );
}
