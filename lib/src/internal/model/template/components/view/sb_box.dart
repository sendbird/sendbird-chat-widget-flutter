// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_align.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_size_spec.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_view_style.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_enums.dart';

part 'sb_box.g.dart';

@JsonSerializable()
class SbBox extends SbView {
  final String layout; // 'row', 'column'
  final SbAlign align;
  @JsonKey(fromJson: SbView.getViewList)
  final List<SbView>? items;

  @JsonKey(includeFromJson: false, includeToJson: false)
  SbLayout? layoutType;

  SbBox({
    required super.type,
    super.width,
    super.height,
    super.viewStyle,
    super.action,
    this.layout = 'row',
    SbAlign? align,
    this.items,
  }) : align = align ?? SbAlign(horizontal: 'left', vertical: 'top');

  factory SbBox.fromJson(Map<String, dynamic> json) => _$SbBoxFromJson(json);
}
