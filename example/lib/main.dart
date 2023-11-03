import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/sendbird_chat_widget.dart';

void main() async {
  // 1. Cache the notification settings and templates after authenticated
  await SendbirdChat.authenticateFeed('USER_ID', accessToken: 'SESSION_TOKEN');
  await SendbirdChatWidget.cacheNotificationInfo();

  // 2. Build a notification bubble widget in your chat view for notifications
  final message =
      NotificationMessage.fromJson({}); // Temporary code for compile

  final notificationBubbleWidget =
      SendbirdChatWidget.buildNotificationBubbleWidget(
    // This value must be a message in messageList in NotificationCollection.
    message: message,
    onClick: (message, view, action) {
      // Handle click event with action.type and action.data
    },
    themeMode: NotificationThemeMode.light, // or dark
    onError: (NotificationWidgetError error) {
      switch (error) {
        case NotificationWidgetError.notificationDisabledError:
          break;
        case NotificationWidgetError.cacheNotFoundError:
          SendbirdChatWidget.cacheNotificationInfo().then((result) {
            if (result) {
              // Refresh this notification bubble widget
            }
          });
          break;
        case NotificationWidgetError.templateNotFoundError:
          SendbirdChatWidget.getNotificationTemplate(
            key: message.notificationData!.templateKey,
          ).then((template) {
            if (template != null) {
              // Refresh this notification bubble widget
            }
          });
          break;
        case NotificationWidgetError.notificationDataNotFoundError:
          break;
        case NotificationWidgetError.unknownError:
          break;
      }
    },
  );

  if (notificationBubbleWidget == null) {
    // The onError() was invoked before.
  }

  // 3. Clear the cache after logout
  await SendbirdChat.disconnect();
  await SendbirdChatWidget.clearCachedNotificationInfo();
}
