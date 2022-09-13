// ignore_for_file: prefer_const_constructors, unnecessary_new, deprecated_member_use, prefer_interpolation_to_compose_strings, unused_label, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:schooldesklight/pages/drawer.dart';
import 'package:schooldesklight/pages/settingdrawer.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../notificationservice/local_notification_service.dart';

Future main() async {
  SubscribeTopic1();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'key',
        channelName: 'SchoolDeskLite',
        channelDescription: 'Testing',
        defaultColor: Colors.amber,
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true)
  ]);
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  await Permission.storage.request();
  runApp(new SchoolDeskWebView(
    weburl: '',
  ));
}

class SchoolDeskWebView extends StatefulWidget {
  final String weburl;
  const SchoolDeskWebView({Key? key, required this.weburl}) : super(key: key);

  @override
  State<SchoolDeskWebView> createState() => _SchoolDeskWebViewState();
}

class _SchoolDeskWebViewState extends State<SchoolDeskWebView> {
  String deviceTokenToSendPushNotification ="";
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  WebViewController? _webViewController;
  // InAppWebViewController? webView;
  late WebViewController controller;
  ScrollController? _scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final cookieManager = WebviewCookieManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SubscribeTopic1();

    /////FCM Registration Token Generate///////////////
    FirebaseMessaging.instance.getToken().then((fcmtoken) async {
      await FirebaseMessaging.instance.subscribeToTopic('NotificationChannel');
      await FirebaseMessaging.instance
          .unsubscribeFromTopic("NotificationChannel");
      print('FCM Token:');
      print(fcmtoken);
    });

    FirebaseMessaging.instance.subscribeToTopic("SchoolDeskLite");

    _scrollController = new ScrollController();
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
    // notification recieved when app is open
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    // = when App in background and not terminated
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }
  //// to get device token///////
	  Future<void> getDeviceTokenToSendNotification() async {
    		final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    		final token = await _fcm.getToken();
    		deviceTokenToSendPushNotification = token.toString();
    		print("Device Token Value $deviceTokenToSendPushNotification");
  	}
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();
    final buttonWidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 255, 204, 0),
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarColor: Color.fromARGB(255, 255, 204, 0),
    ));
    return WillPopScope(
        onWillPop: () => _onBackButtonPressed(context),
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(FontAwesomeIcons.bars));
            }),
            title: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Image.asset(
                'assets/schooldesk.png',
                height: 40,
              ),
            ),
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 255, 201, 8),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingDrawer()));
                  },
                  icon: Icon(FontAwesomeIcons.gear))
            ],
          ),
          body: SafeArea(
              child: GestureDetector(
            onHorizontalDragUpdate: (updateDetails) {},
            child: WebView(
            
                zoomEnabled: true,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.weburl,
                gestureRecognizers: Set()
                  ..add(Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer())),
                userAgent:
                    'Mozilla/5.0 (Linux; Android 5.1.1; Android SDK built for x86 Build/LMY48X) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/39.0.0.0 Mobile Safari/537.36',
                allowsInlineMediaPlayback: true,
                // ignore: prefer_collection_literals
                onWebViewCreated: (webViewController) async {
                  setState(() {
                    webViewController.loadUrl(widget.weburl);
                  });
                  CircularProgressIndicator();
                  _webViewController = webViewController;
                  _controller.complete(webViewController);

                  await cookieManager.clearCookies();
                },
                onProgress: (int progress) {
                  print("WebView is loading (progress : $progress%)");
                },
                javascriptChannels: <JavascriptChannel>{
                  _toasterJavascriptChannel(context),
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith(widget.weburl)) {
                    print('blocking navigation to $request}');
                    return NavigationDecision.prevent;
                  }
                  ;
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                  _webViewController
                      ?.evaluateJavascript("javascript:(function() { " +
                          "var head = document.getElementsByTagName('header')[0];" +
                          "head.parentNode.removeChild(head);" +
                          "var footer = document.getElementsByTagName('footer')[0];" +
                          "footer.parentNode.removeChild(footer);" +
                          "})()")
                      .then((value) =>
                          debugPrint('Page finished loading Javascript'))
                      .catchError((onError) => debugPrint('$onError'));
                }),
          )),
        ));
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
        });
  }

  _onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text('Do You want to close the app?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes')),
            ],
          );
        });
    return exitApp;
  }
}

/////////Topic Subscribed////////

void SubscribeTopic1() async {
  await FirebaseMessaging.instance
      .subscribeToTopic('SchoolDeskLite1')
      .then((value) => Text("Topic 1  Subscribed"));
  // await FirebaseMessaging.instance.unsubscribeFromTopic('SchoolDeskLite1').then((value) => print("Unsubscribed Topic 1"));
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'key',
            title: message.notification?.title,
            body: message.notification?.body));
  });
}

/////////////Topic 2///////////////
void SubscribeTopic2(bool isSubscribed) async {
  if (isSubscribed) {
    const snackBar = SnackBar(content: Text('Subscribed'));
    
      await FirebaseMessaging.instance
      .subscribeToTopic('SchoolDeskLite2')
      .then((value) => Text('$SubscribeTopic2'));
      
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'key',
            title: message.notification?.title,
            body: message.notification?.body));
  });
  } else {
    await FirebaseMessaging.instance.unsubscribeFromTopic('SchoolDeskLite2').then((value) => print('Unsubscribed'));
  }



}

void SubscribeTopic3() async {
  await FirebaseMessaging.instance
      .unsubscribeFromTopic('SchoolDeskLite1')
      .then((value) => Text("unsubscribed"));
  // await FirebaseMessaging.instance.unsubscribeFromTopic('SchoolDeskLite1').then((value) => print("Unsubscribed Topic 1"));
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'key',
            title: message.notification?.title,
            body: message.notification?.body));
  });
}

getExternalStorageDirectory() {}
//6354033887