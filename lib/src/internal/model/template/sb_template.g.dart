// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SbTemplate _$SbTemplateFromJson(Map<String, dynamic> json) => SbTemplate(
      key: json['key'] as String,
      name: json['name'] as String,
      createdAt: json['created_at'] as int,
      updatedAt: json['updated_at'] as int,
      uiTemplate:
          SbUiTemplate.fromJson(json['ui_template'] as Map<String, dynamic>),
      colorVariables: Map<String, String>.from(json['color_variables'] as Map),
    );
