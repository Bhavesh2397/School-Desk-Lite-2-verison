import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingDrawer extends StatefulWidget {
  SettingDrawer({Key? key}) : super(key: key);

  @override
  State<SettingDrawer> createState() => _SettingDrawerState();
}

class _SettingDrawerState extends State<SettingDrawer> {
  bool  value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Image.asset(
            'assets/schooldesk.png',
            height: 40,
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 201, 8),
      ),
      body: Column(
        children: [
          SizedBox(height: 1,),
        ],
      ),
      
      );
  }
}