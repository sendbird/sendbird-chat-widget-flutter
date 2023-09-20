// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_align.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_margin.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_padding.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';

import 'sb_widget_enums.dart';

class SbWidgetUtils {
  static String? getColorInColorsSeparatedByComma({
    required String colorsSeparatedByComma,
    required SbThemeMode themeMode,
  }) {
    final colors = colorsSeparatedByComma.split(',');
    if (colors.length >= 2) {
      if (themeMode == SbThemeMode.light) {
        return colors[0];
      } else if (themeMode == SbThemeMode.dark) {
        return colors[1];
      }
    } else if (colors.length == 1) {
      return colors[0];
    }
    return null;
  }

  static Color? getColor({
    required String colorString,
    required SbThemeMode themeMode,
  }) {
    String? hexColorString = colorString;
    if (colorString.contains(',')) {
      hexColorString = getColorInColorsSeparatedByComma(
        colorsSeparatedByComma: colorString,
        themeMode: themeMode,
      );
    }

    if (hexColorString != null) {
      String hexColor = hexColorString.replaceFirst('#', '');
      if (hexColor.length == 6) hexColor = "ff$hexColor";
      if (hexColor.length == 8) {
        final color = Color(int.parse('0x$hexColor'));
        return color;
      }
    }
    return null;
  }

  static Color? getBackgroundColorFromView({
    required SbView view,
    required SbThemeMode themeMode,
  }) {
    final color = view.viewStyle?.backgroundColor != null
        ? SbWidgetUtils.getColor(
            colorString: view.viewStyle!.backgroundColor!,
            themeMode: themeMode,
          )
        : null;
    return color;
  }

  static double getRadius(dynamic radius) {
    if (radius is int) return radius.toDouble();
    if (radius is String) return double.tryParse(radius) ?? 0;
    return 0;
  }

  static double? getBorderWidth(dynamic borderWidth) {
    if (borderWidth is int) return borderWidth.toDouble();
    if (borderWidth is String) return double.tryParse(borderWidth);
    return null;
  }

  static EdgeInsets getMargin(SbMargin? margin) {
    final left = double.tryParse(margin?.left ?? '') ?? 0;
    final top = double.tryParse(margin?.top ?? '') ?? 0;
    final right = double.tryParse(margin?.right ?? '') ?? 0;
    final bottom = double.tryParse(margin?.bottom ?? '') ?? 0;
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  static EdgeInsets getPadding(SbPadding? padding) {
    final left = double.tryParse(padding?.left ?? '') ?? 0;
    final top = double.tryParse(padding?.top ?? '') ?? 0;
    final right = double.tryParse(padding?.right ?? '') ?? 0;
    final bottom = double.tryParse(padding?.bottom ?? '') ?? 0;
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  static Alignment getAlignment(SbAlign align) {
    double x = -1.0;
    if (align.horizontal == 'left') {
      x = -1.0;
    } else if (align.horizontal == 'center') {
      x = 0.0;
    } else if (align.horizontal == 'right') {
      x = 1.0;
    }

    double y = -1.0;
    if (align.vertical == 'top') {
      y = -1.0;
    } else if (align.vertical == 'center') {
      y = 0.0;
    } else if (align.vertical == 'bottom') {
      y = 1.0;
    }
    return Alignment(x, y);
  }

  static int? getMaxTextLines(String? maxTextLines) {
    return maxTextLines != null ? int.tryParse(maxTextLines) : null;
  }

  static double? getFontSize(String? size) {
    return size != null ? double.tryParse(size) : null;
  }

  static FontWeight getFontWeight(String? weight) {
    FontWeight fontWeight = FontWeight.normal;
    if (weight != null) {
      if (weight == 'normal') fontWeight = FontWeight.normal;
      if (weight == 'bold') fontWeight = FontWeight.bold;
    }
    return fontWeight;
  }

  static double? getWidth(String? width) {
    return width != null ? double.tryParse(width) : null;
  }

  static double? getHeight(String? height) {
    return height != null ? double.tryParse(height) : null;
  }

  static BoxFit? getBoxFit(String? contentMode) {
    BoxFit boxFit = BoxFit.contain;
    if (contentMode == 'aspectFit') {
      boxFit = BoxFit.contain;
    } else if (contentMode == 'aspectFill') {
      boxFit = BoxFit.cover;
    } else if (contentMode == 'scalesToFill') {
      boxFit = BoxFit.fill;
    }
    return boxFit;
  }

  static DecorationImage? getDecorationImage(SbView view) {
    final image = view.viewStyle?.backgroundImageUrl != null
        ? DecorationImage(
            image: NetworkImage(view.viewStyle!.backgroundImageUrl!),
            fit: BoxFit.cover,
          )
        : null;
    return image;
  }

  static double? getDipFromPixel(BuildContext context, String? pixelString) {
    final pixelValue =
        pixelString != null ? double.tryParse(pixelString) : null;
    if (pixelValue != null) {
      return pixelValue / MediaQuery.of(context).devicePixelRatio;
    }
    return null;
  }
}
