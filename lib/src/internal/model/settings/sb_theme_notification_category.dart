// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_theme_notification_category.g.dart';

@JsonSerializable()
class SbThemeNotificationCategory {
  final String textColor;
  final int textSize;
  final String fontWeight;

  SbThemeNotificationCategory({
    required this.textColor,
    required this.textSize,
    required this.fontWeight,
  });

  factory SbThemeNotificationCategory.fromJson(Map<String, dynamic> json) =>
      _$SbThemeNotificationCategoryFromJson(json);
}
