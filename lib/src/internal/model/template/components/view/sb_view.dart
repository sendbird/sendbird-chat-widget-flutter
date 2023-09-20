// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_size_spec.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_view_style.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_box.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_image.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_image_button.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_text.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_text_button.dart';

abstract class SbView {
  final String type; // 'box', 'text', 'textButton', 'image', 'imageButton'
  final SbSizeSpec width;
  final SbSizeSpec height;
  SbViewStyle? viewStyle;
  final SbAction? action;

  @JsonKey(includeFromJson: false, includeToJson: false)
  SbView? parentView;

  SbView({
    required this.type,
    SbSizeSpec? width,
    SbSizeSpec? height,
    this.viewStyle,
    this.action,
  })  : width = width ?? SbSizeSpec(type: 'flex', value: '0'),
        height = height ?? SbSizeSpec(type: 'flex', value: '1');

  static List<SbView> getViewList(List<dynamic> items) {
    final List<SbView> viewList = [];

    for (final Map<String, dynamic> item in items) {
      final type = item['type'];
      if (type != null) {
        switch (type) {
          case 'box':
            viewList.add(SbBox.fromJson(item));
            break;
          case 'text':
            viewList.add(SbText.fromJson(item));
            break;
          case 'image':
            viewList.add(SbImage.fromJson(item));
            break;
          case 'textButton':
            viewList.add(SbTextButton.fromJson(item));
            break;
          case 'imageButton':
            viewList.add(SbImageButton.fromJson(item));
            break;
        }
      }
    }
    return viewList;
  }
}
