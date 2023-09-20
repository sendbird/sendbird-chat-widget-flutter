// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_image_style.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_meta_data.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_size_spec.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_view_style.dart';

part 'sb_image.g.dart';

@JsonSerializable()
class SbImage extends SbView {
  String? imageUrl;
  final SbImageStyle? imageStyle;
  final SbMetaData? metaData;

  SbImage({
    required super.type,
    super.width,
    super.height,
    super.viewStyle,
    super.action,
    this.imageUrl,
    this.imageStyle,
    this.metaData,
  });

  factory SbImage.fromJson(Map<String, dynamic> json) => _$SbImageFromJson(json);
}
