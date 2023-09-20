// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_theme_list_tooltip.g.dart';

@JsonSerializable()
class SbThemeListTooltip {
  final String backgroundColor;
  final String textColor;
  final int textSize;
  final String fontWeight;
  final int radius;

  SbThemeListTooltip({
    required this.backgroundColor,
    required this.textColor,
    required this.textSize,
    required this.fontWeight,
    required this.radius,
  });

  factory SbThemeListTooltip.fromJson(Map<String, dynamic> json) =>
      _$SbThemeListTooltipFromJson(json);
}
