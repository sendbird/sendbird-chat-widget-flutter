// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SbSettings _$SbSettingsFromJson(Map<String, dynamic> json) => SbSettings(
      themes: (json['themes'] as List<dynamic>)
          .map((e) => SbTheme.fromJson(e as Map<String, dynamic>))
          .toList(),
      themeMode: json['theme_mode'] as String,
      updatedAt: json['updated_at'] as int,
    );
