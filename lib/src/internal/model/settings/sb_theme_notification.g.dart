// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_theme_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SbThemeNotification _$SbThemeNotificationFromJson(Map<String, dynamic> json) =>
    SbThemeNotification(
      backgroundColor: json['backgroundColor'] as String,
      category: SbThemeNotificationCategory.fromJson(
          json['category'] as Map<String, dynamic>),
      pressedColor: json['pressedColor'] as String,
      radius: json['radius'] as int,
      sentAt: SbThemeNotificationSentAt.fromJson(
          json['sentAt'] as Map<String, dynamic>),
      unreadIndicatorColor: json['unreadIndicatorColor'] as String,
      label: SbThemeNotificationLabel.fromJson(
          json['label'] as Map<String, dynamic>),
    );
