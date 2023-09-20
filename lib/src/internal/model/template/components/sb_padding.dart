// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_ui_template.dart';

part 'sb_padding.g.dart';

@JsonSerializable()
class SbPadding {
  @JsonKey(fromJson: SbUiTemplate.toNullableString)
  final String? top;
  @JsonKey(fromJson: SbUiTemplate.toNullableString)
  final String? bottom;
  @JsonKey(fromJson: SbUiTemplate.toNullableString)
  final String? left;
  @JsonKey(fromJson: SbUiTemplate.toNullableString)
  final String? right;

  SbPadding({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  factory SbPadding.fromJson(Map<String, dynamic> json) =>
      _$SbPaddingFromJson(json);
}
