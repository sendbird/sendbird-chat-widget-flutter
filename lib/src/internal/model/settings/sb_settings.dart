// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme.dart';

part 'sb_settings.g.dart';

@JsonSerializable()
class SbSettings {
  final List<SbTheme> themes;
  @JsonKey(name: 'theme_mode')
  final String themeMode;
  @JsonKey(name: 'updated_at')
  final int updatedAt;

  SbSettings({
    required this.themes,
    required this.themeMode,
    required this.updatedAt,
  });

  factory SbSettings.fromJson(Map<String, dynamic> json) =>
      _$SbSettingsFromJson(json);
}
