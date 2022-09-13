import 'package:flutter/material.dart';

import '../models/useraccounts.dart';
import '../widgets/useraccount_widget.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Account'), backgroundColor: Colors.amber),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<UserAccount>>(
              future: getUserAccountData(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(parent: null),
                        itemBuilder: (context, index) {
                          var uaccounts = snapshot.data![index];
                          return UserAccountWidget(userAccount: uaccounts);
                        })
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
