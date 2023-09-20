// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_view_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SbViewStyle _$SbViewStyleFromJson(Map<String, dynamic> json) => SbViewStyle(
      backgroundColor: json['backgroundColor'] as String?,
      backgroundImageUrl: json['backgroundImageUrl'] as String?,
      borderWidth: SbUiTemplate.toNullableString(json['borderWidth']),
      borderColor: json['borderColor'] as String?,
      radius: SbUiTemplate.toNullableString(json['radius']),
      margin: json['margin'] == null
          ? null
          : SbMargin.fromJson(json['margin'] as Map<String, dynamic>),
      padding: json['padding'] == null
          ? null
          : SbPadding.fromJson(json['padding'] as Map<String, dynamic>),
    );
