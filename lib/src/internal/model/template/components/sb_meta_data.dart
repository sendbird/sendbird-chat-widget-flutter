// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_ui_template.dart';

part 'sb_meta_data.g.dart';

@JsonSerializable()
class SbMetaData {
  @JsonKey(fromJson: SbUiTemplate.toNotNullString)
  String pixelWidth;
  @JsonKey(fromJson: SbUiTemplate.toNotNullString)
  String pixelHeight;

  SbMetaData({
    required this.pixelWidth,
    required this.pixelHeight,
  });

  factory SbMetaData.fromJson(Map<String, dynamic> json) =>
      _$SbMetaDataFromJson(json);
}
