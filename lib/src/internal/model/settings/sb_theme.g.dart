// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SbTheme _$SbThemeFromJson(Map<String, dynamic> json) => SbTheme(
      key: json['key'] as String,
      notification: SbThemeNotification.fromJson(
          json['notification'] as Map<String, dynamic>),
      list: SbThemeList.fromJson(json['list'] as Map<String, dynamic>),
      header: SbThemeHeader.fromJson(json['header'] as Map<String, dynamic>),
      components: SbThemeComponents.fromJson(
          json['components'] as Map<String, dynamic>),
      createdAt: json['created_at'] as int,
      updatedAt: json['updated_at'] as int,
    );
