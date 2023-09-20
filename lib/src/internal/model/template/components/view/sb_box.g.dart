// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SbBox _$SbBoxFromJson(Map<String, dynamic> json) => SbBox(
      type: json['type'] as String,
      width: json['width'] == null
          ? null
          : SbSizeSpec.fromJson(json['width'] as Map<String, dynamic>),
      height: json['height'] == null
          ? null
          : SbSizeSpec.fromJson(json['height'] as Map<String, dynamic>),
      viewStyle: json['viewStyle'] == null
          ? null
          : SbViewStyle.fromJson(json['viewStyle'] as Map<String, dynamic>),
      action: json['action'] == null
          ? null
          : SbAction.fromJson(json['action'] as Map<String, dynamic>),
      layout: json['layout'] as String? ?? 'row',
      align: json['align'] == null
          ? null
          : SbAlign.fromJson(json['align'] as Map<String, dynamic>),
      items: SbView.getViewList(json['items'] as List),
    );
