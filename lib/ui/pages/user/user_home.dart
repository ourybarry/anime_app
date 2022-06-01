import 'package:anime/resources/authentication/authentication_manager.dart';
import 'package:anime/ui/pages/user/user_activity.dart';
import 'package:anime/ui/pages/user/user_header.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class UserPage extends StatefulWidget {
  final AuthenticationManager _authenticationManager = AuthenticationManager();
  UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<String> _tabs = ['Activity', 'Library'];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                widget._authenticationManager.deleteUserToken();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You have been logged out')));
                Navigator.pop(context);
              },
              icon: Icon(FeatherIcons.logOut))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(),
          UserHeader(),
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            title: Container(
                child: TabBar(
              controller: _tabController,
              tabs: _tabs.map((e) => Text(e)).toList(),
            )),
          ),

          SliverFillRemaining(
              child: TabBarView(controller: _tabController, children: [
            UserActivity(),
            Text(
              'n',
              style: TextStyle(color: Colors.white),
            )
          ]))
        ],
      ),
    );
  }
}
