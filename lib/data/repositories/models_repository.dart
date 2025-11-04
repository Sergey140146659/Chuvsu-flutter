import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/endpoints.dart';
import 'models/model_info.dart';
import 'models_repository_interface.dart';

class ModelsRepository implements ModelsRepositoryInterface {
  ModelsRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<ModelInfo>> getModelsList() async {
    try {
      final response = await dio.get(Endpoints.models);
      final models = (response.data as List)
          .map((e) => ModelInfo.fromJson(e as Map<String, dynamic>))
          .toList();
      return models;
    } on DioException catch (e) {
      throw e;
    }
  }

  @override
  Future<ModelInfo> getModelDetails(String modelId) async {
    try {
      final response = await dio.get(Endpoints.modelById(modelId));
      return ModelInfo.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e;
    }
  }
}
