// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_margin.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_padding.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_ui_template.dart';

part 'sb_view_style.g.dart';

@JsonSerializable()
class SbViewStyle {
  String? backgroundColor;
  final String? backgroundImageUrl;
  @JsonKey(fromJson: SbUiTemplate.toNullableString)
  final String? borderWidth;
  String? borderColor;
  @JsonKey(fromJson: SbUiTemplate.toNullableString)
  final String? radius;
  final SbMargin? margin;
  final SbPadding? padding;

  SbViewStyle({
    this.backgroundColor,
    this.backgroundImageUrl,
    this.borderWidth,
    this.borderColor,
    this.radius,
    this.margin,
    this.padding,
  });

  factory SbViewStyle.fromJson(Map<String, dynamic> json) =>
      _$SbViewStyleFromJson(json);
}
