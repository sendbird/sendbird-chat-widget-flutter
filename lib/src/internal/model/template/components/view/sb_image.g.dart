// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SbImage _$SbImageFromJson(Map<String, dynamic> json) => SbImage(
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
      imageUrl: json['imageUrl'] as String?,
      imageStyle: json['imageStyle'] == null
          ? null
          : SbImageStyle.fromJson(json['imageStyle'] as Map<String, dynamic>),
      metaData: json['metaData'] == null
          ? null
          : SbMetaData.fromJson(json['metaData'] as Map<String, dynamic>),
    );
