// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_ui_template.dart';

part 'sb_template.g.dart';

@JsonSerializable()
class SbTemplate {
  final String key;
  final String name;
  @JsonKey(name: 'created_at')
  final int createdAt;
  @JsonKey(name: 'updated_at')
  final int updatedAt;
  @JsonKey(name: 'ui_template')
  final SbUiTemplate uiTemplate;
  @JsonKey(name: 'color_variables')
  final Map<String, String> colorVariables;

  SbTemplate({
    required this.key,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.uiTemplate,
    required this.colorVariables,
  });

  factory SbTemplate.fromJson(Map<String, dynamic> json) =>
      _$SbTemplateFromJson(json);
}
