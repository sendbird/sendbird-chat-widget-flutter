// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_ui_template.dart';

part 'sb_text_style.g.dart';

@JsonSerializable()
class SbTextStyle {
  String? color;
  @JsonKey(fromJson: SbUiTemplate.toNullableString)
  final String? size;
  final String? weight; // 'normal', 'bold'

  SbTextStyle({
    this.color,
    this.size,
    this.weight,
  });

  factory SbTextStyle.fromJson(Map<String, dynamic> json) =>
      _$SbTextStyleFromJson(json);
}
