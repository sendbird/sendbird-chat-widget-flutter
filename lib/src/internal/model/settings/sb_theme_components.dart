// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_components_text.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_components_text_button.dart';

part 'sb_theme_components.g.dart';

@JsonSerializable()
class SbThemeComponents {
  final SbThemeComponentsText text;
  final SbThemeComponentsTextButton textButton;

  SbThemeComponents({
    required this.text,
    required this.textButton,
  });

  factory SbThemeComponents.fromJson(Map<String, dynamic> json) =>
      _$SbThemeComponentsFromJson(json);
}
