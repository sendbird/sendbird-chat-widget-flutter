// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_ui_template_body.dart';

part 'sb_ui_template.g.dart';

@JsonSerializable()
class SbUiTemplate {
  @JsonKey(fromJson: SbUiTemplate.toNotNullString)
  final String version;
  final SbUiTemplateBody body;

  SbUiTemplate({
    required this.version,
    required this.body,
  });

  factory SbUiTemplate.fromJson(Map<String, dynamic> json) =>
      _$SbUiTemplateFromJson(json);

  static String toNotNullString(dynamic value) {
    if (value is String) return value;
    if (value is int) return value.toString();
    if (value is double) return value.toString();
    if (value is bool) return value.toString();
    return '';
  }

  static String? toNullableString(dynamic value) {
    if (value is String) return value;
    if (value is int) return value.toString();
    if (value is double) return value.toString();
    if (value is bool) return value.toString();
    return null;
  }
}
