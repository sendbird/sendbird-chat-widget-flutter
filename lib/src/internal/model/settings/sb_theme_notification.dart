// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_notification_category.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_notification_label.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_notification_sent_at.dart';

part 'sb_theme_notification.g.dart';

@JsonSerializable()
class SbThemeNotification {
  final String backgroundColor;
  final SbThemeNotificationCategory category;
  final String pressedColor;
  final int radius;
  final SbThemeNotificationSentAt sentAt;
  final String unreadIndicatorColor;
  final SbThemeNotificationLabel label;

  SbThemeNotification({
    required this.backgroundColor,
    required this.category,
    required this.pressedColor,
    required this.radius,
    required this.sentAt,
    required this.unreadIndicatorColor,
    required this.label,
  });

  factory SbThemeNotification.fromJson(Map<String, dynamic> json) =>
      _$SbThemeNotificationFromJson(json);
}
