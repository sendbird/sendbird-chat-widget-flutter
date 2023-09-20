// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_list_category.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_list_timeline.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme_list_tooltip.dart';

part 'sb_theme_list.g.dart';

@JsonSerializable()
class SbThemeList {
  final String backgroundColor;
  final SbThemeListTimeline timeline;
  final SbThemeListTooltip tooltip;
  final SbThemeListCategory category;

  SbThemeList({
    required this.backgroundColor,
    required this.timeline,
    required this.tooltip,
    required this.category,
  });

  factory SbThemeList.fromJson(Map<String, dynamic> json) =>
      _$SbThemeListFromJson(json);
}
