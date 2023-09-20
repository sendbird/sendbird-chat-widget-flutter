// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_theme_components_text_button.g.dart';

@JsonSerializable()
class SbThemeComponentsTextButton {
  final String backgroundColor;
  final int radius;
  final String textColor;

  SbThemeComponentsTextButton({
    required this.backgroundColor,
    required this.radius,
    required this.textColor,
  });

  factory SbThemeComponentsTextButton.fromJson(Map<String, dynamic> json) =>
      _$SbThemeComponentsTextButtonFromJson(json);
}
