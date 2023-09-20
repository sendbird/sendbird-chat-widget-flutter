// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/src/internal/cache/sb_cache_manager.dart';
import 'package:sendbird_chat_widget/src/internal/model/settings/sb_settings.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/sb_action.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/components/view/sb_view.dart';
import 'package:sendbird_chat_widget/src/internal/model/template/sb_template.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_enums.dart';
import 'package:sendbird_chat_widget/src/internal/widget/sb_widget_manager.dart';

/// NotificationThemeMode
typedef NotificationThemeMode = SbThemeMode;

/// NotificationView
typedef NotificationView = SbView;

/// NotificationAction
typedef NotificationAction = SbAction;

/// NotificationWidgetError
enum NotificationWidgetError {
  /// notificationDisabledError
  notificationDisabledError,

  /// Needs to invoke [SendbirdChatWidget.cacheNotificationInfo].
  cacheNotFoundError,

  /// Needs to invoke [SendbirdChatWidget.getNotificationTemplate].
  templateNotFoundError,

  /// notificationDataNotFoundError
  notificationDataNotFoundError,

  /// unknownError
  unknownError,
}

/// SendbirdChatWidget
class SendbirdChatWidget {
  /// sdkVersion
  static const sdkVersion = '1.0.0';

  static final SendbirdChatWidget _instance = SendbirdChatWidget._();

  SendbirdChatWidget._();

  factory SendbirdChatWidget() => _instance;

  bool _isNotificationEnabled = false;
  bool _isNotificationInfoCached = false;

  final _cacheManager = SbCacheManager();
  final _widgetManager = SbWidgetManager();

  /// To cache the notification settings and templates
  /// set on [Sendbird Dashboard](https://dashboard.sendbird.com),
  /// call this method after [SendbirdChat.connect] or [SendbirdChat.authenticateFeed].
  static Future<bool> cacheNotificationInfo() async {
    final notificationInfo = SendbirdChat.getAppInfo()?.notificationInfo;
    if (notificationInfo == null) return false;

    _instance._isNotificationEnabled = notificationInfo.isEnabled;
    if (_instance._isNotificationEnabled == false) return false;

    final result =
        await _instance._cacheManager.cache(notificationInfo: notificationInfo);
    _instance._isNotificationInfoCached = result;
    return result;
  }

  /// Clears the cached notification settings and templates.
  /// Call this method after [SendbirdChat.disconnect].
  static Future<void> clearCachedNotificationInfo() async {
    await _instance._cacheManager.removeAllCache();
  }

  /// Gets the notification settings.
  static Future<SbSettings?> getNotificationSettings() async {
    final settings = await _instance._cacheManager.getSettings();
    if (settings != null) {
      return SbSettings.fromJson(settings);
    }
    return null;
  }

  /// Gets all of the notification template list.
  static Future<List<SbTemplate>?> getNotificationTemplateList() async {
    final templates = await _instance._cacheManager.getTemplates();
    if (templates != null) {
      final List<SbTemplate> notificationTemplateList = [];
      for (final template in templates.values) {
        notificationTemplateList.add(SbTemplate.fromJson(template));
      }
      return notificationTemplateList;
    }
    return null;
  }

  /// Gets the notification template with key.
  static Future<SbTemplate?> getNotificationTemplate({
    required String key,
  }) async {
    final template = await _instance._cacheManager.getTemplate(key: key);
    if (template != null) {
      return SbTemplate.fromJson(template);
    }
    return null;
  }

  /// Builds the notification bubble widget for a notification message
  /// sent on [Sendbird Dashboard](https://dashboard.sendbird.com).
  /// [themeMode] is only applied when the theme colors setting is `Use both light and dark themes`
  /// on [Sendbird Dashboard](https://dashboard.sendbird.com).
  static Widget? buildNotificationBubbleWidget({
    required BaseMessage message,
    required Function(NotificationWidgetError error) onError,
    Function(
      BaseMessage message,
      NotificationView view,
      NotificationAction action,
    )?
        onClick,
    NotificationThemeMode themeMode = NotificationThemeMode.light,
  }) {
    if (message.notificationData == null) {
      onError(NotificationWidgetError.notificationDataNotFoundError);
      return null;
    }
    if (_instance._isNotificationInfoCached == false) {
      onError(NotificationWidgetError.cacheNotFoundError);
      return null;
    }
    if (_instance._isNotificationEnabled == false) {
      onError(NotificationWidgetError.notificationDisabledError);
      return null;
    }

    Widget? widget;

    try {
      final cachedSettings = _instance._cacheManager.cachedSettings;
      if (cachedSettings.isNotEmpty) {
        final settings = SbSettings.fromJson(cachedSettings);

        if (settings.themeMode == 'light') {
          themeMode = NotificationThemeMode.light;
        } else if (settings.themeMode == 'dark') {
          themeMode = NotificationThemeMode.dark;
        }

        final cachedTemplates = _instance._cacheManager.cachedTemplates;
        final cachedTemplate =
            cachedTemplates[message.notificationData!.templateKey];
        if (cachedTemplate != null &&
            (cachedTemplate as Map<String, dynamic>).isNotEmpty) {
          // debugPrint(
          //     '[SendbirdChatWidget][buildNotificationBubbleWidget()][cache()][template]'
          //     ' key: ${message.notificationData!.templateKey}\n'
          //     '${const JsonEncoder.withIndent('  ').convert(cachedTemplate)}');

          final template = SbTemplate.fromJson(cachedTemplate);

          // debugPrint(
          //     '[SendbirdChatWidget][buildNotificationBubbleWidget()][templateVariables]\n'
          //     '${const JsonEncoder.withIndent('  ').convert(message.notificationData!.templateVariables)}');
          widget = _instance._widgetManager.buildNotificationBubbleWidget(
            message: message,
            themeMode: themeMode,
            settings: settings,
            template: template,
            notificationData: message.notificationData!,
            onClick: onClick,
          );
        } else {
          onError(NotificationWidgetError.templateNotFoundError);
          return null;
        }
      } else {
        onError(NotificationWidgetError.cacheNotFoundError);
        return null;
      }
    } catch (e) {
      debugPrint(
          '[SendbirdChatWidget][buildNotificationBubbleWidget()][e] ${e.toString()}');
      onError(NotificationWidgetError.unknownError);
      return null;
    }

    return widget;
  }
}
