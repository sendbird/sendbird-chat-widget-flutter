// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_components.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_header.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_list.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_notification.dart';

part 'sb_theme.g.dart';

@JsonSerializable()
class SbTheme {
  final String key; // 'default'
  final SbThemeNotification notification;
  final SbThemeList list;
  final SbThemeHeader header;
  final SbThemeComponents components;
  @JsonKey(name: 'created_at')
  final int createdAt;
  @JsonKey(name: 'updated_at')
  final int updatedAt;

  SbTheme({
    required this.key,
    required this.notification,
    required this.list,
    required this.header,
    required this.components,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SbTheme.fromJson(Map<String, dynamic> json) => _$SbThemeFromJson(json);
}
