# [Sendbird](https://sendbird.com) Chat Widget for Flutter

[![Platform](https://img.shields.io/badge/platform-flutter-blue)](https://flutter.dev/)
[![Language](https://img.shields.io/badge/language-dart-blue)](https://dart.dev/)

## Flutter Notifications (Feed) SDK

This guide will lead you through the process of integrating a Notification Center into your web or mobile application. Leveraging Sendbird's Flutter SDK(`Chat SDK` and `Widget SDK`), you'll discover how to authenticate users and work with notification templates to create a persistent notification feed.

## Before You Start
Before diving into codes and notifications, you'll need to set up some essentials on [Sendbird Dashboard](https://dashboard.sendbird.com).

1. `Create a Sendbird Account`: Head to Sendbird Dashboard and sign up for a free trial account. If you're already a Sendbird user, sign in.

2. `Create New Application`: Once you're in, click on the `Create +` button located at the bottom-right corner to create a new application.

    `Note`: Sendbird Notifications is currently supported in the following regions: Singapore, Oregon, Frankfurt, N. Virginia and Mumbai.

3. `Locate Application ID`: Navigate to the application you've just created under the `Applications` section. Here, you'll find your Application ID—keep it handy as you'll need it for initializing the Chat SDK.

4. `Onboard Notifications`: Jump into the `Notifications` menu on the left menu bar and complete the onboarding sequence. This is where you'll set up everything from notification types to templates.

5. `Create a Template`: Finally, go to `Notifications` > `Templates` and click the `Create template +` button to design a notification template that fits your needs.
    - `Templates`: Templates are a customizable, preset data format for notification messages, serving as the structure of the messages. Once you build them on the dashboard, each template will have `template_key` as its unique identifier. Make note of `template_key` for the customization of the template in the future.
    
    - `Variables`: While the template serves as the structure or construction of the message, template variables allow notifications to carry personalized content. Variables are the customizable parts of the template that you can change each time you send a notification. There are three different types of variables that Sendbird Notifications provides: [string, image, and action](https://sendbird.com/docs/notifications/guide/v1/templates#2-set-variables). Once a notification is sent, those variables will be contained in `notificationData`.
  
`Note`: The template preview on the dashboard is for reference only and doesnʼt reflect the actual UI of the notification on the client app. To render notifications as intended, you need to create your own UI components first. For more information about rendering notifications, go to `Step 8`.

## Getting Started

Now, we can begin implementing the SDK.

### Step 1. Create a dependency
Create a dependency and add the following code to your package's `pubspec.yaml` file.

```yaml
dependencies:
  sendbird_chat_sdk: ^4.1.1
  sendbird_chat_widget: ^1.0.2
```

### Step 2. Install packages
Install packages from the command line.

```
% flutter pub get
```

### Step 3. Import packages
You can run the following import statement to start using all classes and methods.

```dart
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_widget/sendbird_chat_widget.dart';
```

### Step 4. Initialize the Chat SDK
Now, initialize the Chat SDK in the app to allow the SDK to respond to changes in the connection status of Flutter client apps. Initialization requires your Sendbird application's Application ID, which can be found on Sendbird Dashboard.

```dart
SendbirdChat.init(appId: 'APP_ID');
```

### Step 5. Authenticate to the Sendbird server
In order to ensure that a user's notifications are properly secured, Sendbird recommends that our customers require `sessionTokens` in order for end users to connect via the SDK. To do this, navigate to Sendbird Dashboard and select your application. Go to `Settings` > `Security` > Select `Deny login` under `Access token permissions`. This ensures that any user that attempts to connect without a `sessionToken` or `accessToken` is denied.

Now that we’ve enforced the requirement for `sessionTokens`, we need to be able to properly handle what happens to a user's session when the token is revoked or expired. For this reason, before we connect to the Sendbird server, we need to implement session handlers.

```dart
SendbirdChat.setSessionHandler(MySessionHandler());

// ...

class MySessionHandler extends SessionHandler {
  @override
  void onAccessTokenRequired(AccessTokenRequester accessTokenRequester) async {
    // Issue sessionToken, if success
    await accessTokenRequester.onSuccess('newAccessToken');
    // If failed
    await accessTokenRequester.onFail();
  }

  @override
  void onSessionClosed() {
    // Session is closed
  }

  @override
  void onSessionRefreshed() {
    // Session is refreshed
  }

  @override
  void onSessionError(SendbirdException e) {
    // Session refresh failed
  }
}
```

Once sessionHandlers have been set, we can authenticate to the Sendbird servers using the `SendbirdChat.authenticateFeed()` method. This method will require a `userId` and `accessToken`(the same as sessionToken). As `sessionTokens` can only be generated via the Platform API, Sendbird recommends that you generate the user’s `sessionToken` in your backend service and then pass it to the client via a wrapper function. `Sendbird strongly advises that you do not utilize the Platform API directly in your client-facing application as you risk exposing your API token`.

* To learn how to generate a session token, [refer to this page](https://sendbird.com/docs/chat/platform-api/v3/user/managing-session-tokens/issue-a-session-token).

```dart
try {
  final user = await SendbirdChat.authenticateFeed(USER_ID, accessToken: SESSION_TOKEN);
  // The user is authenticated but WebSocket is not connected.
} catch (e) {
  // Handle error.
}
```

### Step 6. Load a feed channel
You can retrieve a channel instance through `getChannel(channelUrl)`.

```dart
final feedChannel = await FeedChannel.getChannel(channelUrl);
```

### Step 7. Set up a notification collection
Once a feed channel is retrieved, you can create `NotificationCollection()` to implement the notification list view. `NotificationCollection` allows you to swiftly create a notification channel view that contains all the necessary message data.

```dart
final collection = NotificationCollection(
  channel: channel,
  params: MessageListParams(),
  handler: MyNotificationCollectionHandler(),
);
collection.initialize();

// ...

class MyNotificationCollectionHandler extends NotificationCollectionHandler {
  @override
  void onMessagesAdded(NotificationContext context, FeedChannel channel,
      List<NotificationMessage> messages) {}

  @override
  void onMessagesUpdated(NotificationContext context, FeedChannel channel,
      List<NotificationMessage> messages) {}

  @override
  void onMessagesDeleted(NotificationContext context, FeedChannel channel,
      List<NotificationMessage> messages) {}

  @override
  void onChannelUpdated(FeedChannelContext context, FeedChannel channel) {}

  @override
  void onChannelDeleted(FeedChannelContext context, String deletedChannelUrl) {}

  @override
  void onHugeGapDetected() {}
}
```

For the pagination of the view, you could use `collection.loadPrevious()` or `collection.loadNext()` to retrieve messages in a certain direction. One way to use the `loadPrevious()` and `loadNext()` is to call the methods when the scroll hits the top or the bottom.

To keep your feed channel data up-to-date, you should utilize the `SendbirdChat.refreshNotificationCollections()` to check for new notifications or channel updates. It’s recommended that you refresh the collection whenever the application goes from the background to the foreground.

In order to receive information about updates when the refresh occurs, you’ll need to implement `NotificationCollectionHandler`.

### Step 8. Render a notification bubble with the Widget SDK
First, you have to cache the notification settings and templates with `SendbirdChatWidget.cacheNotificationInfo()` to build a notification bubble widget after `SendbirdChat.authenticateFeed()`.

```dart
await SendbirdChat.authenticateFeed(USER_ID, accessToken: SESSION_TOKEN);
await SendbirdChatWidget.cacheNotificationInfo();
```

In order to build the notification bubble widget from a notification message, you can use `SendbirdChatWidget.buildNotificationBubbleWidget()`.

```dart
final notificationBubbleWidget = SendbirdChatWidget.buildNotificationBubbleWidget(
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
```

You are recommended to call `SendbirdChatWidget.clearCachedNotificationInfo()` to clear the cached notification settings and templates after `SendbirdChat.disconnect()`.

```dart
await SendbirdChat.disconnect();
await SendbirdChatWidget.clearCachedNotificationInfo();
```

## Appendix

### NotificationData
Every notification message will have `notificationData` which looks like the following:

```dart
class NotificationData {
  final String templateKey;
  final Map<String, dynamic> templateVariables;
  String? label;
  List<String> tags;
}
```

`NotificationData` is an interface that contains all variable information about a single notification. It’s created in a way that once you set up a template, a notification can be sent with a label, a customized template key, and a set of variables: `label` is used for sub-categorization of notifications; `templateKey` is an unique identifier of the template used for the notification; `templateVariables` is an object of customizable key-value pairs you’ve set for the template. Pass these variables to your custom UI components to render each notification.

### Variables
Variables are the customizable parts of the template that you can change each time you send a notification. Such data will be contained in `notificationData` of every notification you
send using a template. Use the interface when rendering notifications on the client app as it
contains the template key and variables you’ve set on [Sendbird Dashboard](https://dashboard.sendbird.com). To learn more, see [Notification Guide on Variables](https://sendbird.com/docs/notifications/guide/v1/templates#2-set-variables).

### Categories
`NotificationCategory` is a notification category of a feed channel defined in Sendbird Dashboard. A feed channel could have more than one notification category but has at least one, which is a default category. You could get the notification categories from the feed channel instance as below.

```dart
// type: List<NotificationCategory>
channel.notificationCategories;
```

And each `NotificationCategory` looks like the following:

```dart
class NotificationCategory {
  final int id;
  final String customType;
  final String name;
  final bool isDefault;
}
```

### Filtering by Category
Before you can utilize category filters, you must first enable filtering on any channels. To do this, navigate to your application in Sendbird Dashboard and go to Notifications > Channels. Then select your channel and turn on the Category filters feature.

In the SDK, you can check whether a channel supports category filters by calling `feedChannel.isCategoryFilterEnabled`.

Once configured, you can utilize the following:

```dart
final params = MessageListParams()..customTypes = [
  channel.notificationCategories[targetCategoryIndex].customType,
];
final collection = NotificationCollection(
  channel: channel,
  params: params,
  handler: MyNotificationCollectionHandler(),
);
collection.initialize();
```
