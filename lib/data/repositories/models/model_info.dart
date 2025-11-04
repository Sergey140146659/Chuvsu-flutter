import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_info.g.dart';

@JsonSerializable()
class ModelInfo extends Equatable {
  const ModelInfo({
    required this.id,
    this.author,
    required this.createdAt,
    this.pipelineTag,
  });

  @JsonKey(name: 'modelId')
  final String id;

  final String? author;

  final DateTime createdAt;

  @JsonKey(name: 'pipeline_tag')
  final String? pipelineTag;

  factory ModelInfo.fromJson(Map<String, dynamic> json) =>
      _$ModelInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ModelInfoToJson(this);

  @override
  List<Object?> get props => [id, author, createdAt, pipelineTag];
}
