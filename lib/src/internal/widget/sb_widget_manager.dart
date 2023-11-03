// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_settings.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_text_style.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_view_style.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_box.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_image.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_image_button.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_text.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_text_button.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_template.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_widget_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_enums.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_utils.dart';

class SbWidgetManager {
  Widget buildNotificationBubbleWidget({
    required NotificationMessage message,
    required SbThemeMode themeMode,
    required SbSettings settings,
    required SbTemplate template,
    required NotificationData notificationData,
    Function(
      NotificationMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
  }) {
    for (final view in template.uiTemplate.body.items) {
      _applyColorVariablesToUiTemplate(
        view: view,
        colorVariables: template.colorVariables,
        themeMode: themeMode,
      );
    }

    if (settings.themes.isNotEmpty) {
      for (final view in template.uiTemplate.body.items) {
        _applySettingsToNullValuesInUiTemplate(
          view: view,
          theme: settings.themes[0],
          themeMode: themeMode,
        );
      }
    }

    for (final view in template.uiTemplate.body.items) {
      _applyTemplateVariablesToUiTemplate(
        view: view,
        theme: settings.themes[0],
        templateVariables: notificationData.templateVariables,
      );
    }

    return SbWidgetBuilder.buildNotificationBubbleWidget(
      message: message,
      template: template,
      theme: settings.themes[0],
      themeMode: themeMode,
      onClick: onClick,
    );
  }

  void _applyColorVariablesToUiTemplate({
    required SbView view,
    required Map<String, String> colorVariables,
    required SbThemeMode themeMode,
  }) {
    // [View] viewStyle.backgroundColor
    if (view.viewStyle != null && view.viewStyle!.backgroundColor != null) {
      final color = _getColorInColorVariables(
        color: view.viewStyle!.backgroundColor!,
        colorVariables: colorVariables,
        themeMode: themeMode,
      );
      if (color != null) {
        view.viewStyle!.backgroundColor = color;
      }
    }

    // [View] viewStyle.borderColor
    if (view.viewStyle != null && view.viewStyle!.borderColor != null) {
      final color = _getColorInColorVariables(
        color: view.viewStyle!.borderColor!,
        colorVariables: colorVariables,
        themeMode: themeMode,
      );
      if (color != null) {
        view.viewStyle!.borderColor = color;
      }
    }

    // [Text] textStyle.color
    if (view is SbText) {
      if (view.textStyle != null && view.textStyle!.color != null) {
        final color = _getColorInColorVariables(
          color: view.textStyle!.color!,
          colorVariables: colorVariables,
          themeMode: themeMode,
        );
        if (color != null) {
          view.textStyle!.color = color;
        }
      }
    }

    // [TextButton] textStyle.color
    if (view is SbTextButton) {
      if (view.textStyle != null && view.textStyle!.color != null) {
        final color = _getColorInColorVariables(
          color: view.textStyle!.color!,
          colorVariables: colorVariables,
          themeMode: themeMode,
        );
        if (color != null) {
          view.textStyle!.color = color;
        }
      }
    }

    // [Image] imageStyle.tintColor
    if (view is SbImage) {
      if (view.imageStyle != null && view.imageStyle!.tintColor != null) {
        final color = _getColorInColorVariables(
          color: view.imageStyle!.tintColor!,
          colorVariables: colorVariables,
          themeMode: themeMode,
        );
        if (color != null) {
          view.imageStyle!.tintColor = color;
        }
      }
    }

    // [ImageButton] imageStyle.tintColor
    if (view is SbImageButton) {
      if (view.imageStyle != null && view.imageStyle!.tintColor != null) {
        final color = _getColorInColorVariables(
          color: view.imageStyle!.tintColor!,
          colorVariables: colorVariables,
          themeMode: themeMode,
        );
        if (color != null) {
          view.imageStyle!.tintColor = color;
        }
      }
    }

    // [Box]
    if (view is SbBox) {
      if (view.items != null) {
        for (final view in view.items!) {
          _applyColorVariablesToUiTemplate(
            view: view,
            colorVariables: colorVariables,
            themeMode: themeMode,
          );
        }
      }
    }
  }

  String? _getColorInColorVariables({
    required String color,
    required Map<String, String> colorVariables,
    required SbThemeMode themeMode,
  }) {
    if (color.length >= 3 && color[0] == '{') {
      final colorVariable = color.substring(1, color.length - 1);
      if (colorVariables[colorVariable] != null) {
        return SbWidgetUtils.getColorInColorsSeparatedByComma(
          colorsSeparatedByComma: colorVariables[colorVariable]!,
          themeMode: themeMode,
        );
      }
    }
    return null;
  }

  void _applySettingsToNullValuesInUiTemplate({
    required SbView view,
    required SbTheme theme,
    required SbThemeMode themeMode,
  }) {
    final textTextColor = SbWidgetUtils.getColorInColorsSeparatedByComma(
      colorsSeparatedByComma: theme.components.text.textColor,
      themeMode: themeMode,
    );
    final textButtonBgColor = SbWidgetUtils.getColorInColorsSeparatedByComma(
      colorsSeparatedByComma: theme.components.textButton.backgroundColor,
      themeMode: themeMode,
    );
    final textButtonTextColor = SbWidgetUtils.getColorInColorsSeparatedByComma(
      colorsSeparatedByComma: theme.components.textButton.textColor,
      themeMode: themeMode,
    );

    // [View] viewBgColor, textButtonBgColor
    if (view.viewStyle == null) {
      view.viewStyle = SbViewStyle(
          backgroundColor: view is SbTextButton ? textButtonBgColor : null);
    } else if (view.viewStyle!.backgroundColor == null) {
      view.viewStyle!.backgroundColor =
          view is SbTextButton ? textButtonBgColor : null;
    }

    // [Text] textTextColor
    if (view is SbText) {
      if (view.textStyle == null) {
        view.textStyle = SbTextStyle(color: textTextColor);
      } else if (view.textStyle!.color == null) {
        view.textStyle!.color = textTextColor;
      }
    }

    // [TextButton] textButtonTextColor
    if (view is SbTextButton) {
      if (view.textStyle == null) {
        view.textStyle = SbTextStyle(color: textButtonTextColor);
      } else if (view.textStyle!.color == null) {
        view.textStyle!.color = textButtonTextColor;
      }
    }

    // [Box]
    if (view is SbBox) {
      if (view.items != null) {
        for (final view in view.items!) {
          _applySettingsToNullValuesInUiTemplate(
            view: view,
            theme: theme,
            themeMode: themeMode,
          );
        }
      }
    }
  }

  void _applyTemplateVariablesToUiTemplate({
    required SbView view,
    required SbTheme theme,
    required Map<String, dynamic> templateVariables,
  }) {
    // [View] action.type, action.data
    if (view.action != null) {
      view.action!.type = _replaceVariableWithValueInTemplateVariables(
        stringToCheck: view.action!.type,
        templateVariables: templateVariables,
      );

      view.action!.data = _replaceVariableWithValueInTemplateVariables(
        stringToCheck: view.action!.data,
        templateVariables: templateVariables,
      );
    }

    // [Text] text
    if (view is SbText) {
      view.text = _replaceVariableWithValueInTemplateVariables(
        stringToCheck: view.text,
        templateVariables: templateVariables,
      );
    }

    // [TextButton] text
    if (view is SbTextButton) {
      view.text = _replaceVariableWithValueInTemplateVariables(
        stringToCheck: view.text,
        templateVariables: templateVariables,
      );
    }

    // [Image] imageUrl, metaData.pixelWidth, metaData.pixelHeight
    if (view is SbImage) {
      if (view.imageUrl != null) {
        view.imageUrl = _replaceVariableWithValueInTemplateVariables(
          stringToCheck: view.imageUrl!,
          templateVariables: templateVariables,
        );
      }

      if (view.metaData != null) {
        view.metaData!.pixelWidth =
            _replaceVariableWithValueInTemplateVariables(
          stringToCheck: view.metaData!.pixelWidth,
          templateVariables: templateVariables,
        );

        view.metaData!.pixelHeight =
            _replaceVariableWithValueInTemplateVariables(
          stringToCheck: view.metaData!.pixelHeight,
          templateVariables: templateVariables,
        );
      }
    }

    // [ImageButton] imageUrl, metaData.pixelWidth, metaData.pixelHeight
    if (view is SbImageButton) {
      if (view.imageUrl != null) {
        view.imageUrl = _replaceVariableWithValueInTemplateVariables(
          stringToCheck: view.imageUrl!,
          templateVariables: templateVariables,
        );
      }

      if (view.metaData != null) {
        view.metaData!.pixelWidth =
            _replaceVariableWithValueInTemplateVariables(
          stringToCheck: view.metaData!.pixelWidth,
          templateVariables: templateVariables,
        );

        view.metaData!.pixelHeight =
            _replaceVariableWithValueInTemplateVariables(
          stringToCheck: view.metaData!.pixelHeight,
          templateVariables: templateVariables,
        );
      }
    }

    // [Box]
    if (view is SbBox) {
      if (view.items != null) {
        for (final view in view.items!) {
          _applyTemplateVariablesToUiTemplate(
            view: view,
            theme: theme,
            templateVariables: templateVariables,
          );
        }
      }
    }
  }

  String _replaceVariableWithValueInTemplateVariables({
    required String stringToCheck,
    required Map<String, dynamic> templateVariables,
  }) {
    String result = stringToCheck;
    for (final variable in templateVariables.keys) {
      dynamic value = templateVariables[variable];
      if (value is int || value is double) {
        value = value.toString();
      }

      if (value is String) {
        result = result.replaceAll('{$variable}', value);
      }
    }
    return result;
  }
}
