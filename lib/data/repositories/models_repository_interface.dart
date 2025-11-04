import 'models/model_info.dart';

abstract interface class ModelsRepositoryInterface {
  Future<List<ModelInfo>> getModelsList();
  Future<ModelInfo> getModelDetails(String modelId);
}
