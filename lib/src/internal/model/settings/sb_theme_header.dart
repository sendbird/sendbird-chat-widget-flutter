// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_theme_header.g.dart';

@JsonSerializable()
class SbThemeHeader {
  final String backgroundColor;
  final String buttonIconTintColor;
  final String lineColor;
  final String textColor;
  final int textSize;
  final String fontWeight;

  SbThemeHeader({
    required this.backgroundColor,
    required this.buttonIconTintColor,
    required this.lineColor,
    required this.textColor,
    required this.textSize,
    required this.fontWeight,
  });

  factory SbThemeHeader.fromJson(Map<String, dynamic> json) =>
      _$SbThemeHeaderFromJson(json);
}
