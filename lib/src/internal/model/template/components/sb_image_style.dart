// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_image_style.g.dart';

@JsonSerializable()
class SbImageStyle {
  final String
      contentMode; // Default: 'aspectFit', 'aspectFill', 'scalesToFill'
  String? tintColor; // for ImageButton

  SbImageStyle({
    this.contentMode = 'aspectFit',
    this.tintColor,
  });

  factory SbImageStyle.fromJson(Map<String, dynamic> json) =>
      _$SbImageStyleFromJson(json);
}
