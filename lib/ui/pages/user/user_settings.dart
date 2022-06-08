import 'package:flutter/material.dart';

class UserSettings extends StatelessWidget {
  final _settings = [
    'Profile',
    'Notifications',
    'Password',
    'Privacy',
    'Accounts',
    'Import',
    'Export',
    'Block',
    'Delete my account'
  ];

  UserSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: ((context, index) => Container(
                // height: 30,
                padding: EdgeInsets.all(10),
                child: Text(_settings.elementAt(index),
                    style: TextStyle(color: Colors.white)),
              )),
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
          itemCount: _settings.length),
    );
  }
}
