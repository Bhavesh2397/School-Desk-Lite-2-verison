


import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooldesklight/pages/SchoolDeskWebView.dart';
import 'package:schooldesklight/pages/login.dart';
import 'package:schooldesklight/pages/useraccountpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'notificationservice/local_notification_service.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  	print(message.data.toString());
 	print(message.notification!.title);
	}
  
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return  MaterialApp(
          themeMode: ThemeMode.light,
          navigatorObservers: [BotToastNavigatorObserver()],
          initialRoute: "/",
      routes: {
        '/': (context) => const SplashScreen(),
        '/UserAccountPage': (context) => const UserAccountPage(),
      },
          title: 'Shool Desk',
          debugShowCheckedModeBanner: false,
          builder: BotToastInit(),
          
     
        );
      },

    );
  }

  static init() {}
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{
  String? apiToken;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 2500),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  
  apiTokenData() async {
    print('asdfjhbsadhjf');
    SharedPreferences preferences = await SharedPreferences.getInstance();

    apiToken = preferences.getString('ApiToken');

  }

  @override
  initState() {
    super.initState();
    apiTokenData();
    navigationMethod();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  navigationMethod() {
    Future.delayed(Duration(milliseconds: 4000), () {
      if (apiToken == null || apiToken == '') {
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) => SchoolDeskWebView(weburl: '',)));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 204, 0),
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset('assets/beesplashlogo.png',height: 200,width: 200,)
        ),
      ),
    );
  }

}

