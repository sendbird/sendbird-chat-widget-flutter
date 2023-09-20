// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SbCacheManager {
  final prefSettingsUpdatedAt = 'com.sendbird.chat.widget.settings_updated_at';
  final prefSettings = 'com.sendbird.chat.widget.settings';
  final prefTemplateListToken = 'com.sendbird.chat.widget.template_list_token';
  final prefTemplates = 'com.sendbird.chat.widget.templates';

  SharedPreferences? _sharedPreferences;

  Map<String, dynamic> cachedSettings = {};
  Map<String, dynamic> cachedTemplates = {};

  Future<SharedPreferences> get _prefs async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  Future<bool> cache({
    required NotificationInfo notificationInfo,
  }) async {
    try {
      // Settings
      final cachedSettingsUpdatedAt = await _getSettingsUpdatedAt();
      if (cachedSettingsUpdatedAt == null ||
          cachedSettingsUpdatedAt < notificationInfo.settingsUpdatedAt) {
        final Map<String, dynamic> settings =
            (await SendbirdChat.getGlobalNotificationChannelSetting()).setting;

        // debugPrint(
        //     '[SendbirdChatWidget][SbCacheManager][cache()][Settings][API]\n'
        //     '${const JsonEncoder.withIndent('  ').convert(settings)}');

        if (await _setSettingsUpdatedAt(notificationInfo.settingsUpdatedAt) ==
            false) {
          return false;
        }
        if (await _setSettings(settings) == false) {
          return false;
        }
      } else {
        final settings = await getSettings();
        if (settings != null && settings.isNotEmpty) {
          cachedSettings.clear();
          cachedSettings.addAll(settings);

          // debugPrint(
          //     '[SendbirdChatWidget][SbCacheManager][cache()][Settings][CACHE]\n'
          //     '${const JsonEncoder.withIndent('  ').convert(settings)}');
        } else {
          return false;
        }
      }

      // Templates
      final cachedTemplateListToken = await _getTemplateListToken();
      if (cachedTemplateListToken == null ||
          cachedTemplateListToken != notificationInfo.templateListToken) {
        final Map<String, dynamic> templates = {};

        if (cachedTemplateListToken != null) {
          final cachedTemplates = await getTemplates();
          if (cachedTemplates != null) {
            templates.addAll(cachedTemplates);
          }
        }

        String? templateListToken = notificationInfo.templateListToken;
        if (cachedTemplateListToken == null) templateListToken = null;

        NotificationTemplateList? templateList;
        do {
          templateList = await SendbirdChat.getNotificationTemplateListByToken(
            NotificationTemplateListParams(limit: 100),
            token: templateListToken,
          );

          final List<dynamic>? newTemplates =
              templateList.templateList['templates'];
          if (newTemplates != null) {
            for (final newTemplate in newTemplates) {
              final String? key = newTemplate['key'];
              if (key != null && key.isNotEmpty) {
                templates[key] = newTemplate;
              }
            }
          }

          templateListToken = templateList.token;
        } while (templateList.hasMore);

        // debugPrint(
        //     '[SendbirdChatWidget][SbCacheManager][cache()][Templates][API]\n'
        //     '${const JsonEncoder.withIndent('  ').convert(templates)}');

        if (await _setTemplateListToken(templateListToken) == false) {
          return false;
        }
        if (await _setTemplates(templates) == false) {
          return false;
        }
      } else {
        final templates = await getTemplates();
        if (templates != null && templates.isNotEmpty) {
          cachedTemplates.clear();
          cachedTemplates.addAll(templates);

          // debugPrint(
          //     '[SendbirdChatWidget][SbCacheManager][cache()][Templates][CACHE]\n'
          //     '${const JsonEncoder.withIndent('  ').convert(templates)}');
        } else {
          return false;
        }
      }
    } catch (e) {
      debugPrint(
          '[SendbirdChatWidget][SbCacheManager][cache()][e] ${e.toString()}');
      return false;
    }
    return true;
  }

  Future<void> removeAllCache() async {
    final prefs = (await _prefs);
    await prefs.remove(prefSettingsUpdatedAt);
    await prefs.remove(prefSettings);
    await prefs.remove(prefTemplateListToken);
    await prefs.remove(prefTemplates);

    cachedSettings.clear();
    cachedTemplates.clear();
  }

  Future<Map<String, dynamic>?> getSettings() async {
    final settings = (await _prefs).getString(prefSettings);
    if (settings != null) {
      return jsonDecode(settings);
    }
    return null;
  }

  Future<Map<String, dynamic>?> getTemplates() async {
    final templates = (await _prefs).getString(prefTemplates);
    if (templates != null) {
      return jsonDecode(templates);
    }
    return null;
  }

  Future<Map<String, dynamic>?> getTemplate({
    required String key,
  }) async {
    final Map<String, dynamic>? templates = await getTemplates();
    if (templates != null && templates[key] != null) {
      return templates[key];
    }
    return await _fetchTemplate(key: key);
  }

  Future<Map<String, dynamic>?> _fetchTemplate({
    required String key,
  }) async {
    final Map<String, dynamic> templates = {};
    final cachedTemplates = await getTemplates();
    if (cachedTemplates != null) {
      templates.addAll(cachedTemplates);
    }

    try {
      Map<String, dynamic> newTemplate =
          (await SendbirdChat.getNotificationTemplate(key: key)).template;
      templates[key] = newTemplate;

      await _setTemplates(templates);
      return newTemplate;
    } catch (e) {
      return null;
    }
  }

  Future<int?> _getSettingsUpdatedAt() async {
    return (await _prefs).getInt(prefSettingsUpdatedAt);
  }

  Future<bool> _setSettingsUpdatedAt(int settingsUpdatedAt) async {
    final result =
        (await _prefs).setInt(prefSettingsUpdatedAt, settingsUpdatedAt);
    return result;
  }

  Future<bool> _setSettings(Map<String, dynamic> settings) async {
    final result =
        await ((await _prefs).setString(prefSettings, jsonEncode(settings)));
    if (result) {
      cachedSettings.clear();
      cachedSettings.addAll(settings);
    }
    return result;
  }

  Future<String?> _getTemplateListToken() async {
    return (await _prefs).getString(prefTemplateListToken);
  }

  Future<bool> _setTemplateListToken(String? templateListToken) async {
    if (templateListToken == null || templateListToken.isEmpty) {
      return (await _prefs).remove(prefTemplateListToken);
    } else {
      return (await _prefs).setString(prefTemplateListToken, templateListToken);
    }
  }

  Future<bool> _setTemplates(Map<String, dynamic> templates) async {
    final result =
        await ((await _prefs).setString(prefTemplates, jsonEncode(templates)));
    if (result) {
      cachedTemplates.clear();
      cachedTemplates.addAll(templates);
    }
    return result;
  }
}
