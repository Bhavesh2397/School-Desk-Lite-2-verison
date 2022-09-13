// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:schooldesklight/pages/SchoolDeskWebView.dart';

import '../models/useraccounts.dart';
import '../utils/theme.dart';


class UserAccountWidget extends StatefulWidget {
  final UserAccount userAccount;
  const UserAccountWidget({Key? key, required this.userAccount})
      : super(key: key);

  @override
  State<UserAccountWidget> createState() => _UserAccountWidgetState();
}

class _UserAccountWidgetState extends State<UserAccountWidget> {
  var webtoken = "";
  var baseURL = "";

  void getweburl() async {
    CircularProgressIndicator(
      backgroundColor: Colors.amber,
    );
    await webLogin().then((pref) async {
      setState(() {
        webtoken = pref!;
        baseURL = BaseConfig.webURL;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SchoolDeskWebView(
                    weburl: "$baseURL$webtoken&ReturnUrl=public/login")));
      });
    });
    //await getUserContextData();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CircularProgressIndicator(
          backgroundColor: Colors.amber,
        );
      },
      child: Card(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height * 0.1,
        color: Color.fromARGB(255, 255, 204, 0),
        child: ListTile(
          title: Text(widget.userAccount.fullName),
          subtitle: Text(widget.userAccount.userType),
        ),
      ),
    );
  }
}
/////////////////icon//////////
