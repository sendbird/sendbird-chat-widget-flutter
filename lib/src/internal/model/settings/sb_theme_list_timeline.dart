// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_theme_list_timeline.g.dart';

@JsonSerializable()
class SbThemeListTimeline {
  final String backgroundColor;
  final String textColor;
  final int textSize;
  final String fontWeight;

  SbThemeListTimeline({
    required this.backgroundColor,
    required this.textColor,
    required this.textSize,
    required this.fontWeight,
  });

  factory SbThemeListTimeline.fromJson(Map<String, dynamic> json) =>
      _$SbThemeListTimelineFromJson(json);
}
