// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_image.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_template.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_widget_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_enums.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_utils.dart';

class SbImageBuilder {
  static Widget? buildImageWidget({
    required NotificationMessage message,
    required SbTemplate template,
    required SbImage image,
    required SbTheme theme,
    required SbThemeMode themeMode,
    Function(
      NotificationMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
  }) {
    // String? imageUrl
    // ImageStyle? imageStyle
    // MetaData? metaData
    final tintColor = image.imageStyle?.tintColor != null
        ? SbWidgetUtils.getColor(
            colorString: image.imageStyle!.tintColor!, themeMode: themeMode)
        : null;

    final bgColor = image.viewStyle?.backgroundColor != null
        ? SbWidgetUtils.getColor(
            colorString: image.viewStyle!.backgroundColor!,
            themeMode: themeMode)
        : null;

    Widget? childWidget;
    if (image.imageUrl != null) {
      childWidget = ClipRRect(
        borderRadius: BorderRadius.circular(
          SbWidgetUtils.getRadius(image.viewStyle?.radius),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Image.network(
              image.imageUrl!,
              fit: SbWidgetUtils.getBoxFit(image.imageStyle?.contentMode),
              color: tintColor?.opacity == 0 || bgColor?.opacity == 0
                  ? null
                  : tintColor,
              colorBlendMode: BlendMode.srcIn,
              loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) =>
                  _getSizedBox(
                context: context,
                viewWidth: constraints.maxWidth,
                viewHeight: constraints.maxHeight,
                image: image,
                child: child,
              ),
              errorBuilder: (buildContext, object, _) => _getSizedBox(
                context: context,
                viewWidth: constraints.maxWidth,
                viewHeight: constraints.maxHeight,
                image: image,
              ),
            );
          },
        ),
      );
    } else {
      childWidget = LayoutBuilder(builder: (context, constraints) {
        return _getSizedBox(
          context: context,
          viewWidth: constraints.maxWidth,
          viewHeight: constraints.maxHeight,
          image: image,
        );
      });
    }

    return SbWidgetBuilder.tryToAddGestureDetector(
      message: message,
      template: template,
      view: image,
      onClick: onClick,
      child: childWidget,
    );
  }

  static Widget _getSizedBox({
    required BuildContext context,
    required double viewWidth,
    required double viewHeight,
    required SbImage image,
    Widget? child,
  }) {
    double? width;
    double? height;

    final imageWidth =
        SbWidgetUtils.getDipFromPixel(context, image.metaData?.pixelWidth);
    final imageHeight =
        SbWidgetUtils.getDipFromPixel(context, image.metaData?.pixelHeight);

    if (imageWidth != null &&
        imageWidth > 0 &&
        imageHeight != null &&
        imageHeight > 0) {
      if (viewWidth == double.infinity && viewHeight == double.infinity) {
        width = imageWidth;
        height = imageHeight;
      } else if (viewWidth != double.infinity &&
          viewHeight == double.infinity) {
        width = imageWidth;
        height = viewWidth * (imageHeight / imageWidth);
      } else if (viewWidth == double.infinity &&
          viewHeight != double.infinity) {
        width = viewHeight * (imageWidth / imageHeight);
        height = imageHeight;
      }
    }

    return SizedBox(
      width: width,
      height: height,
      child: child ?? Container(color: Colors.transparent),
    );
  }
}
