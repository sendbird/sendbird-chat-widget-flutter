// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_theme_notification_sent_at.g.dart';

@JsonSerializable()
class SbThemeNotificationSentAt {
  final String textColor;
  final int textSize;
  final String fontWeight;

  SbThemeNotificationSentAt({
    required this.textColor,
    required this.textSize,
    required this.fontWeight,
  });

  factory SbThemeNotificationSentAt.fromJson(Map<String, dynamic> json) =>
      _$SbThemeNotificationSentAtFromJson(json);
}
