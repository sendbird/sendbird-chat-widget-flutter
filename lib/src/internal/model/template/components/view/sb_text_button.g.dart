// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_text_button.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SbTextButton _$SbTextButtonFromJson(Map<String, dynamic> json) => SbTextButton(
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
      text: json['text'] as String,
      maxTextLines: json['maxTextLines'] == null
          ? '1'
          : SbUiTemplate.toNotNullString(json['maxTextLines']),
      textStyle: json['textStyle'] == null
          ? null
          : SbTextStyle.fromJson(json['textStyle'] as Map<String, dynamic>),
    );
