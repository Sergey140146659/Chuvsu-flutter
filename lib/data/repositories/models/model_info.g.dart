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
  siblings: (json['siblings'] as List<dynamic>?)
      ?.map((e) => Sibling.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Sibling _$SiblingFromJson(Map<String, dynamic> json) =>
    Sibling(rfilename: json['rfilename'] as String);
