// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_image_button.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_template.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_image_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_enums.dart';

class SbImageButtonBuilder {
  static Widget? buildImageButtonWidget({
    required NotificationMessage message,
    required SbTemplate template,
    required SbImageButton imageButton,
    required SbTheme theme,
    required SbThemeMode themeMode,
    Function(
      NotificationMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
  }) {
    return SbImageBuilder.buildImageWidget(
      message: message,
      template: template,
      image: imageButton,
      theme: theme,
      themeMode: themeMode,
      onClick: onClick,
    );
  }
}
