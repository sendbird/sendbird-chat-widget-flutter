// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_text.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_template.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_widget_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_enums.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_utils.dart';

class SbTextBuilder {
  static Widget? buildTextWidget({
    required NotificationMessage message,
    required SbTemplate template,
    required SbText text,
    required SbTheme theme,
    required SbThemeMode themeMode,
    Function(
      NotificationMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
  }) {
    // Align align
    final alignment = SbWidgetUtils.getAlignment(text.align);

    // String text
    // String? maxTextLines
    // TextStyle? textStyle
    final childWidget = Text(
      text.text,
      maxLines: SbWidgetUtils.getMaxTextLines(text.maxTextLines),
      style: TextStyle(
        color: text.textStyle?.color != null
            ? SbWidgetUtils.getColor(
                colorString: text.textStyle!.color!, themeMode: themeMode)
            : null,
        fontSize: SbWidgetUtils.getFontSize(text.textStyle?.size),
        fontWeight: SbWidgetUtils.getFontWeight(text.textStyle?.weight),
      ),
      overflow: TextOverflow.ellipsis,
    );

    return SbWidgetBuilder.tryToAddGestureDetector(
      message: message,
      template: template,
      view: text,
      onClick: onClick,
      child: Align(
        alignment: alignment,
        child: childWidget,
      ),
    );
  }
}
