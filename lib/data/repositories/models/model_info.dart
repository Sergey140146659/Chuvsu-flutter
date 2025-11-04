import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_info.g.dart';

@JsonSerializable(createToJson: false)
class ModelInfo extends Equatable {
  const ModelInfo({
    required this.id,
    this.author,
    required this.createdAt,
     this.pipelineTag,
    this.siblings,
  });

  @JsonKey(name: 'modelId')
  final String id;
  final String? author;
  final DateTime createdAt;
  @JsonKey(name: 'pipeline_tag')
  final String? pipelineTag;

  final List<Sibling>? siblings;

  factory ModelInfo.fromJson(Map<String, dynamic> json) =>
      _$ModelInfoFromJson(json);

  @override
  List<Object?> get props => [id, author, createdAt, pipelineTag, siblings];
}

@JsonSerializable(createToJson: false)
class Sibling extends Equatable {
  const Sibling({required this.rfilename});

  final String rfilename;

  factory Sibling.fromJson(Map<String, dynamic> json) =>
      _$SiblingFromJson(json);

  @override
  List<Object?> get props => [rfilename];
}
