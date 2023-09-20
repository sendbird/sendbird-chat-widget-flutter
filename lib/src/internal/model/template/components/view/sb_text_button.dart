// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_size_spec.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_view_style.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_ui_template.dart';

import '../sb_text_style.dart';

part 'sb_text_button.g.dart';

@JsonSerializable()
class SbTextButton extends SbView {
  String text;
  @JsonKey(fromJson: SbUiTemplate.toNotNullString)
  final String maxTextLines;
  SbTextStyle? textStyle;

  SbTextButton({
    required super.type,
    super.width,
    super.height,
    super.viewStyle,
    super.action,
    required this.text,
    this.maxTextLines = '1',
    this.textStyle,
  });

  factory SbTextButton.fromJson(Map<String, dynamic> json) =>
      _$SbTextButtonFromJson(json);
}
