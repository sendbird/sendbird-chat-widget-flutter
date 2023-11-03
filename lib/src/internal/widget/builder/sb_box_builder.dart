// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_theme.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_align.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_box.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_template.dart';
import 'package:sendbird_chat_widget/src/internal/widget/builder/sb_widget_builder.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_enums.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_utils.dart';

class SbBoxBuilder {
  static Widget? buildBoxWidget({
    required NotificationMessage message,
    required SbTemplate template,
    required SbView? parentView,
    required SbBox box,
    required SbTheme theme,
    required SbThemeMode themeMode,
    Function(
      NotificationMessage message,
      SbView view,
      SbAction action,
    )?
        onClick,
  }) {
    // String layout
    // List<View>? items
    Widget? childWidget;
    if (box.items != null && box.items!.isNotEmpty) {
      SbLayout layoutType = SbLayout.column; // Check;
      if (box.layout == 'row') {
        if (box.height.type == 'flex' && box.height.value == '0' ||
            box.width.type == 'flex' && box.width.value == '0') {
          layoutType = SbLayout.row;
        } else {
          layoutType = SbLayout.rowWrap;
        }
      } else if (box.layout == 'column') {
        if (box.width.type == 'flex' && box.width.value == '0' ||
            box.height.type == 'flex' && box.height.value == '0') {
          layoutType = SbLayout.column;
        } else {
          layoutType = SbLayout.columnWrap;
        }
      }

      box.layoutType = layoutType; // Check

      List<Widget> widgets = [];
      for (final view in box.items!) {
        final widget = SbWidgetBuilder.buildWidget(
          message: message,
          template: template,
          parentView: box,
          view: view,
          theme: theme,
          themeMode: themeMode,
          onClick: onClick,
        );
        if (widget != null) {
          widgets.add(widget);
        }
      }

      if (widgets.isNotEmpty) {
        if (layoutType == SbLayout.row) {
          childWidget = Row(
            mainAxisAlignment: _getRowMainAxisAlignment(box.align),
            crossAxisAlignment: _getRowCrossAxisAlignment(box.align),
            children: widgets,
          );
        } else if (layoutType == SbLayout.rowWrap) {
          // Check (!)
          childWidget = Wrap(
            direction: Axis.vertical,
            children: [
              // Check (!)
              Row(
                mainAxisAlignment: _getRowMainAxisAlignment(box.align),
                crossAxisAlignment: _getRowCrossAxisAlignment(box.align),
                children: widgets,
              ),
            ],
          );
        } else if (layoutType == SbLayout.column) {
          childWidget = Column(
            mainAxisAlignment: _getColumnMainAxisAlignment(box.align),
            crossAxisAlignment: _getColumnCrossAxisAlignment(box.align),
            children: widgets,
          );
        } else if (layoutType == SbLayout.columnWrap) {
          childWidget = Wrap(
            alignment: _getColumnWrapAlignment(box.align),
            crossAxisAlignment: _getColumnWrapCrossAlignment(box.align),
            direction: Axis.vertical,
            children: widgets,
          );
        }
      }
    }

    double? width;
    if (box.width.type == 'fixed') {
      width = SbWidgetUtils.getWidth(box.width.value);
    }

    double? height;
    if (box.height.type == 'fixed') {
      height = SbWidgetUtils.getHeight(box.height.value);
    }

    if (box.width.type == 'flex' &&
        box.width.value == '0' &&
        box.height.type == 'flex' &&
        box.height.value == '0') {
      width = double.infinity;
      height = double.infinity;
    }

    final container = ClipRRect(
      borderRadius: BorderRadius.circular(
        SbWidgetUtils.getRadius(box.viewStyle?.radius),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: childWidget,
      ),
    );

    return SbWidgetBuilder.tryToAddGestureDetector(
      message: message,
      template: template,
      view: box,
      onClick: onClick,
      child: container,
    );
  }

  static MainAxisAlignment _getRowMainAxisAlignment(SbAlign align) {
    MainAxisAlignment alignment = MainAxisAlignment.start;
    if (align.horizontal == 'left') {
      alignment = MainAxisAlignment.start;
    } else if (align.horizontal == 'center') {
      alignment = MainAxisAlignment.center;
    } else if (align.horizontal == 'right') {
      alignment = MainAxisAlignment.end;
    }
    return alignment;
  }

  static CrossAxisAlignment _getRowCrossAxisAlignment(SbAlign align) {
    CrossAxisAlignment alignment = CrossAxisAlignment.start;
    if (align.vertical == 'top') {
      alignment = CrossAxisAlignment.start;
    } else if (align.vertical == 'center') {
      alignment = CrossAxisAlignment.center;
    } else if (align.vertical == 'bottom') {
      alignment = CrossAxisAlignment.end;
    }
    return alignment;
  }

  static MainAxisAlignment _getColumnMainAxisAlignment(SbAlign align) {
    MainAxisAlignment alignment = MainAxisAlignment.start;
    if (align.vertical == 'top') {
      alignment = MainAxisAlignment.start;
    } else if (align.vertical == 'center') {
      alignment = MainAxisAlignment.center;
    } else if (align.vertical == 'bottom') {
      alignment = MainAxisAlignment.end;
    }
    return alignment;
  }

  static CrossAxisAlignment _getColumnCrossAxisAlignment(SbAlign align) {
    CrossAxisAlignment alignment = CrossAxisAlignment.start;
    if (align.horizontal == 'left') {
      alignment = CrossAxisAlignment.start;
    } else if (align.horizontal == 'center') {
      alignment = CrossAxisAlignment.center;
    } else if (align.horizontal == 'right') {
      alignment = CrossAxisAlignment.end;
    }
    return alignment;
  }

  static WrapAlignment _getColumnWrapAlignment(SbAlign align) {
    WrapAlignment alignment = WrapAlignment.start;
    if (align.vertical == 'top') {
      alignment = WrapAlignment.start;
    } else if (align.vertical == 'center') {
      alignment = WrapAlignment.center;
    } else if (align.vertical == 'bottom') {
      alignment = WrapAlignment.end;
    }
    return alignment;
  }

  static WrapCrossAlignment _getColumnWrapCrossAlignment(SbAlign align) {
    WrapCrossAlignment alignment = WrapCrossAlignment.start;
    if (align.horizontal == 'left') {
      alignment = WrapCrossAlignment.start;
    } else if (align.horizontal == 'center') {
      alignment = WrapCrossAlignment.center;
    } else if (align.horizontal == 'right') {
      alignment = WrapCrossAlignment.end;
    }
    return alignment;
  }
}
