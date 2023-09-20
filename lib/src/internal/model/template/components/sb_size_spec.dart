// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_ui_template.dart';

part 'sb_size_spec.g.dart';

@JsonSerializable()
class SbSizeSpec {
  final String type; // 'fixed', 'flex'
  @JsonKey(fromJson: SbUiTemplate.toNotNullString)
  final String value; // '100', '0'(FILL_PARENT), '1'(WRAP_CONTENT)

  SbSizeSpec({
    required this.type,
    required this.value,
  });

  factory SbSizeSpec.fromJson(Map<String, dynamic> json) =>
      _$SbSizeSpecFromJson(json);
}
