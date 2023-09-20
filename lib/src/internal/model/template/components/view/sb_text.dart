// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_align.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_size_spec.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_view_style.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_ui_template.dart';

import '../sb_text_style.dart';

part 'sb_text.g.dart';

@JsonSerializable()
class SbText extends SbView {
  String text;
  final SbAlign align;
  @JsonKey(fromJson: SbUiTemplate.toNullableString)
  final String? maxTextLines;
  SbTextStyle? textStyle;

  SbText({
    required super.type,
    super.width,
    super.height,
    super.viewStyle,
    super.action,
    required this.text,
    SbAlign? align,
    this.maxTextLines,
    this.textStyle,
  }) : align = align ?? SbAlign(horizontal: 'left', vertical: 'top');

  factory SbText.fromJson(Map<String, dynamic> json) => _$SbTextFromJson(json);
}
