// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_box.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_image.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_image_button.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_text.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_text_button.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_template.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_box_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_image_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_image_button_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_text_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_text_button_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_enums.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_utils.dart';

class SbWidgetBuilder {
  // [theme.notification.backgroundColor] Apply to the body
  // [theme.notification.radius] Apply to the body
  // [theme.components.textButton.radius] Apply to the TextButton
  static Widget buildNotificationBubbleWidget({
    required NotificationMessage message,
    required SbTemplate template,
    required SbTheme theme,
    required SbThemeMode themeMode,
    Function(
      NotificationMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        SbWidgetUtils.getRadius(theme.notification.radius),
      ),
      child: Container(
        color: SbWidgetUtils.getColor(
          colorString: theme.notification.backgroundColor,
          themeMode: themeMode,
        ),
        child: Column(
          // Check
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildBodyItems(
            message: message,
            template: template,
            views: template.uiTemplate.body.items,
            theme: theme,
            themeMode: themeMode,
            onClick: onClick,
          ),
        ),
      ),
    );
  }

  static List<Widget> _buildBodyItems({
    required NotificationMessage message,
    required SbTemplate template,
    required List<SbView> views,
    required SbTheme theme,
    required SbThemeMode themeMode,
    Function(
      NotificationMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
  }) {
    List<Widget> widgets = [];
    for (final view in views) {
      final rootBox = buildWidget(
        message: message,
        template: template,
        parentView: null,
        view: view,
        theme: theme,
        themeMode: themeMode,
        onClick: onClick,
      );
      if (rootBox != null) {
        widgets.add(rootBox);
      }
    }
    return widgets;
  }

  static Widget? buildWidget({
    required NotificationMessage message,
    required SbTemplate template,
    required SbBox? parentView,
    required SbView view,
    required SbTheme theme,
    required SbThemeMode themeMode,
    Function(
      NotificationMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
  }) {
    // String type
    Widget? widget;
    switch (view.type) {
      case 'box':
        widget = SbBoxBuilder.buildBoxWidget(
          message: message,
          template: template,
          parentView: parentView,
          box: view as SbBox,
          theme: theme,
          themeMode: themeMode,
          onClick: onClick,
        );
        break;
      case 'text':
        widget = SbTextBuilder.buildTextWidget(
          message: message,
          template: template,
          text: view as SbText,
          theme: theme,
          themeMode: themeMode,
          onClick: onClick,
        );
        break;
      case 'textButton':
        widget = SbTextButtonBuilder.buildTextButtonWidget(
          message: message,
          template: template,
          textButton: view as SbTextButton,
          theme: theme,
          themeMode: themeMode,
          onClick: onClick,
        );
        break;
      case 'image':
        widget = SbImageBuilder.buildImageWidget(
          message: message,
          template: template,
          image: view as SbImage,
          theme: theme,
          themeMode: themeMode,
          onClick: onClick,
        );
        break;
      case 'imageButton':
        widget = SbImageButtonBuilder.buildImageButtonWidget(
          message: message,
          template: template,
          imageButton: view as SbImageButton,
          theme: theme,
          themeMode: themeMode,
          onClick: onClick,
        );
        break;
    }

    // SizeSpec
    bool addExpandedForRow = false;

    // SizeSpec width
    double? width;
    if (view.width.type == 'fixed') {
      width = SbWidgetUtils.getWidth(view.width.value);
    } else if (view.width.type == 'flex' && view.width.value == '0') {
      if (parentView?.layoutType == SbLayout.row) {
        addExpandedForRow = true;
      } else if (parentView?.layoutType == SbLayout.column) {
        // [Check] If there is a Fill(flex/0) width in this view's parent.
        if (view.parentView?.width.type == 'flex' &&
            view.parentView?.width.value == '0') {
          // [Check] The parents should not have Fit(flex/1) or Fixed width.
          if (_hasFitWidthInParents(view.parentView)) {
            // [Check] Just pass.
          } else {
            width = double.infinity;
          }
        } else {
          width = double.infinity;
        }
      }
    }

    // SizeSpec height
    double? height;
    if (view.height.type == 'fixed') {
      height = SbWidgetUtils.getHeight(view.height.value);
    }

    if (view.width.type == 'flex' &&
        view.width.value == '0' &&
        view.height.type == 'flex' &&
        view.height.value == '0') {
      width = double.infinity;
      height = double.infinity;
    }

    // ViewStyle? viewStyle
    final bgImage = SbWidgetUtils.getDecorationImage(view);
    final bgColor = SbWidgetUtils.getBackgroundColorFromView(
      view: view,
      themeMode: themeMode,
    );

    // String? borderWidth
    // String? borderColor
    BoxBorder? border;
    final borderWidth =
        SbWidgetUtils.getBorderWidth(view.viewStyle?.borderWidth);
    final borderColor = view.viewStyle?.borderColor != null
        ? SbWidgetUtils.getColor(
            colorString: view.viewStyle!.borderColor!, themeMode: themeMode)
        : null;
    if (borderWidth != null && borderColor != null) {
      border = Border.all(width: borderWidth, color: borderColor);
    }

    final container = border != null && view is SbImageButton
        ? Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                width: width,
                height: height,
                margin: SbWidgetUtils.getMargin(view.viewStyle?.margin),
                padding: SbWidgetUtils.getPadding(view.viewStyle?.padding),
                decoration: BoxDecoration(
                  image: bgImage,
                  color: bgColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                        SbWidgetUtils.getRadius(view.viewStyle?.radius)),
                  ),
                ),
                child: widget,
              ),
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image: bgImage,
                  color: bgColor,
                  border: border,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                        SbWidgetUtils.getRadius(view.viewStyle?.radius)),
                  ),
                ),
              ),
            ],
          )
        : Container(
            width: width,
            height: height,
            margin: SbWidgetUtils.getMargin(view.viewStyle?.margin),
            padding: SbWidgetUtils.getPadding(view.viewStyle?.padding),
            decoration: BoxDecoration(
              image: bgImage,
              color: bgColor,
              border: border,
              borderRadius: BorderRadius.all(
                Radius.circular(
                    SbWidgetUtils.getRadius(view.viewStyle?.radius)),
              ),
            ),
            child: widget,
          );

    final clickableWidget = SbWidgetBuilder.tryToAddGestureDetector(
      message: message,
      template: template,
      view: view,
      onClick: onClick,
      child: container,
    );

    if (addExpandedForRow) {
      return Expanded(child: clickableWidget);
    }
    return clickableWidget;
  }

  static bool _hasFitWidthInParents(SbView? view) {
    if (view?.parentView == null) {
      return false;
    } else if (view?.parentView?.width.type == 'flex' &&
        view?.parentView?.width.value == '1') {
      return true;
    }
    return _hasFitWidthInParents(view?.parentView!);
  }

  static Widget tryToAddGestureDetector({
    required NotificationMessage message,
    required SbTemplate template,
    required SbView view,
    required Function(
      NotificationMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
    required Widget child,
  }) {
    if (view.action == null) return child;

    return GestureDetector(
      onTap: () {
        SbWidgetBuilder.onViewClicked(
          message: message,
          template: template,
          view: view,
          onClick: onClick,
        );
      },
      child: child,
    );
  }

  static void onViewClicked({
    required NotificationMessage message,
    required SbTemplate template,
    required SbView view,
    required Function(
      NotificationMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
  }) {
    if (view.action != null && onClick != null) {
      // Click event
      onClick(message, view, view.action!);

      try {
        FeedChannel.getChannel(message.channelUrl)
            .then((channel) => channel.markAsClicked([message]));
      } catch (_) {}
    }
  }
}
