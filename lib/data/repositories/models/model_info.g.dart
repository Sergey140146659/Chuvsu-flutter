// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelInfo _$ModelInfoFromJson(Map<String, dynamic> json) => ModelInfo(
  id: json['modelId'] as String,
  author: json['author'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  pipelineTag: json['pipeline_tag'] as String?,
);

Map<String, dynamic> _$ModelInfoToJson(ModelInfo instance) => <String, dynamic>{
  'modelId': instance.id,
  'author': instance.author,
  'createdAt': instance.createdAt.toIso8601String(),
  'pipeline_tag': instance.pipelineTag,
};
