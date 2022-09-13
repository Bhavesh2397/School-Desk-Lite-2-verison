// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooldesklight/pages/SchoolDeskWebView.dart';
import 'package:schooldesklight/pages/useraccountpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../utils/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
 bool isSubscribed = true;
  var uContext = LocalStoredModel(
      token: '',
      appUserHash: '',
      profileURL: '',
      userName: '',
      deviceId: '',
      fullName: '',
      userType: '',
      appUserId: 0,
      email: '',
      isAccountActive: false,
      isLoggedIn: false,
      mobile: '',
      profileImage: '',
      fcmtoken: '',
      remoteUId: '');
  @override
  void initState() {
    updatecontext();
    super.initState();
  }

  void updatecontext() async {
    await getUserContextData().then((pref) async {
      setState(() {
        uContext = pref;
      });
    });
    //await getUserContextData();
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 255, 204, 0),
        systemNavigationBarDividerColor: Color.fromARGB(255, 255, 204, 0),
        systemNavigationBarColor: Color.fromARGB(255, 255, 204, 0),
        systemNavigationBarIconBrightness: Brightness.dark));
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/UserAccountPage');
                  },
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 114, 198, 164)),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 97, 167, 139),
                      backgroundImage: NetworkImage(
                        uContext.profileImage,
                      ),
                      onBackgroundImageError: (_, __) {
                        setState(() {
                          //this._isError = true;
                        });
                      },

                      //  backgroundImage: NetworkImage(uContext.profileImage),
                    ),
                    accountName: Text(uContext.fullName),
                    accountEmail: Text(uContext.email),
                  ),
                )),

            ListTile(
              hoverColor: Color.fromARGB(255, 255, 204, 0),
              leading: Icon(FontAwesomeIcons.calculator,
                  color: Color.fromARGB(255, 119, 119, 119)),
              title: Text(
                'Mathametics',
                textScaleFactor: 1,
                style: GoogleFonts.kanit(
                    color: Color.fromARGB(255, 119, 119, 119)),
              ),
            ),
            
            ListTile(
              leading: Icon(FontAwesomeIcons.flask,
                  size: 20, color: Color.fromARGB(255, 119, 119, 119)),
              title: Text(
                'Science',
                textScaleFactor: 1,
                style: GoogleFonts.kanit(
                    color: Color.fromARGB(255, 119, 119, 119)),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              indent: 5,
              endIndent: 10,
              color: Colors.amber,
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.message,
                  color: Color.fromARGB(255, 119, 119, 119)),
              title: Text(
                'Announcement',
                textScaleFactor: 1,
                style: GoogleFonts.kanit(
                    color: Color.fromARGB(255, 119, 119, 119)),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.gear,
                  color: Color.fromARGB(255, 119, 119, 119)),
              title: Text(
                'Settings',
                textScaleFactor: 1,
                style: GoogleFonts.kanit(
                    color: Color.fromARGB(255, 119, 119, 119)),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            // /SubscribeTopic1()
            InkWell(
            
              onTap: NotificationSubscribed,
              child: ListTile(
                leading: Icon( Icons.notifications),
                title: Text(
                  'Subscribe School Topics 2',
                  textScaleFactor: 1,
                  style: GoogleFonts.kanit(
                      color: Color.fromARGB(255, 119, 119, 119)),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('UserName');
                prefs.clear();
                var isLoggedIn = await deleteAllUserContext();
                if (isLoggedIn.isLoggedIn == false &&
                    isLoggedIn.token.isEmpty) {
                  Navigator.of(context).pushNamed('/');
                }
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.rightFromBracket,
                    color: Color.fromARGB(255, 119, 119, 119)),
                title: Text(
                  'Log Out',
                  textScaleFactor: 1,
                  style: GoogleFonts.kanit(
                      color: Color.fromARGB(255, 119, 119, 119)),
                ),
              ),
            ),
            SizedBox(
              height: 160,
            ),
            Divider(
              height: 1,
              thickness: 1,
              indent: 6,
              endIndent: 6,
              color: Color.fromARGB(255, 255, 204, 0),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
                child: Text(
              'School Desk',
              style: GoogleFonts.kanit(
                fontSize: 15,
                color: Color.fromARGB(255, 255, 204, 0),
              ),
            )),
            Center(
                child: Text(
              'Version 1.0.0',
              style: GoogleFonts.kanit(color: Colors.grey, fontSize: 12),
            ))
          ],
        ),
      ),
    );
  }

  void NotificationSubscribed() {
    if (isSubscribed == true) {
      SnackBar(content: Text('Subscribed'));
      FontAwesomeIcons.bellSlash;

      isSubscribed = false;
      SubscribeTopic2(isSubscribed);
    } else {
      isSubscribed = true;
      SubscribeTopic2(isSubscribed);
      FontAwesomeIcons.bell;
    }
    setState(() {
      isSubscribed = !isSubscribed;
    });
  }
}
