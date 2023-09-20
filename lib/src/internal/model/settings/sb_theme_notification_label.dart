// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_theme_notification_label.g.dart';

@JsonSerializable()
class SbThemeNotificationLabel {
  final String textColor;
  final int textSize;
  final String fontWeight;

  SbThemeNotificationLabel({
    required this.textColor,
    required this.textSize,
    required this.fontWeight,
  });

  factory SbThemeNotificationLabel.fromJson(Map<String, dynamic> json) =>
      _$SbThemeNotificationLabelFromJson(json);
}
