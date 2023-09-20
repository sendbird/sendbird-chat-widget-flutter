// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_box.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';

part 'sb_ui_template_body.g.dart';

@JsonSerializable()
class SbUiTemplateBody {
  @JsonKey(fromJson: SbView.getViewList)
  final List<SbView> items;

  SbUiTemplateBody({
    required this.items,
  });

  factory SbUiTemplateBody.fromJson(Map<String, dynamic> json) {
    final body = _$SbUiTemplateBodyFromJson(json);
    _setParentView(null, body.items);
    return body;
  }

  static void _setParentView(SbView? parentView, List<SbView>? items) {
    if (items != null) {
      for (final view in items) {
        view.parentView = parentView;
        if (view is SbBox) {
          _setParentView(view, view.items);
        }
      }
    }
  }
}
