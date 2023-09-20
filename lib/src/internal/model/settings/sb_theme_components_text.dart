// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_theme_components_text.g.dart';

@JsonSerializable()
class SbThemeComponentsText {
  final String textColor;

  SbThemeComponentsText({
    required this.textColor,
  });

  factory SbThemeComponentsText.fromJson(Map<String, dynamic> json) =>
      _$SbThemeComponentsTextFromJson(json);
}
