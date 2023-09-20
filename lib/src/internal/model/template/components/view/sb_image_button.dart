// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_image_style.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_meta_data.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_size_spec.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_view_style.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_image.dart';

part 'sb_image_button.g.dart';

@JsonSerializable()
class SbImageButton extends SbImage {
  SbImageButton({
    required super.type,
    super.width,
    super.height,
    super.viewStyle,
    super.action,
    super.imageUrl,
    super.imageStyle,
    super.metaData,
  });

  factory SbImageButton.fromJson(Map<String, dynamic> json) =>
      _$SbImageButtonFromJson(json);
}
