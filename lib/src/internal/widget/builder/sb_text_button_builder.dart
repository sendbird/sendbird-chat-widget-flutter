// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_text_button.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_template.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_widget_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_enums.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_utils.dart';

class SbTextButtonBuilder {
  static Widget? buildTextButtonWidget({
    required BaseMessage message,
    required SbTemplate template,
    required SbTextButton textButton,
    required SbTheme theme,
    required SbThemeMode themeMode,
    Function(
      BaseMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
  }) {
    // String text
    // String? maxTextLines
    // TextStyle? textStyle
    final childWidget = TextButton(
      onPressed: textButton.action != null
          ? () => SbWidgetBuilder.onViewClicked(
                message: message,
                template: template,
                view: textButton,
                onClick: onClick,
              )
          : null,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        textButton.text,
        maxLines: SbWidgetUtils.getMaxTextLines(textButton.maxTextLines),
        style: TextStyle(
          color: textButton.textStyle?.color != null
              ? SbWidgetUtils.getColor(
                  colorString: textButton.textStyle!.color!,
                  themeMode: themeMode)
              : null,
          fontSize: SbWidgetUtils.getFontSize(textButton.textStyle?.size),
          fontWeight: SbWidgetUtils.getFontWeight(textButton.textStyle?.weight),
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );

    return GestureDetector(
      onTap: childWidget.onPressed, // Check
      child: childWidget,
    );
  }
}
