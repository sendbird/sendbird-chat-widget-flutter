// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_theme_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SbThemeList _$SbThemeListFromJson(Map<String, dynamic> json) => SbThemeList(
      backgroundColor: json['backgroundColor'] as String,
      timeline: SbThemeListTimeline.fromJson(
          json['timeline'] as Map<String, dynamic>),
      tooltip:
          SbThemeListTooltip.fromJson(json['tooltip'] as Map<String, dynamic>),
      category: SbThemeListCategory.fromJson(
          json['category'] as Map<String, dynamic>),
    );
