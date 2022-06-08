import 'package:anime/resources/authentication/authentication_manager.dart';
import 'package:anime/resources/model/user/user.dart';
import 'package:anime/resources/repository/user_repository.dart';
import 'package:anime/ui/pages/user/user_settings.dart';
import 'package:anime/ui/pages/user/user_activity.dart';
import 'package:anime/ui/pages/user/user_header.dart';
// import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class UserPage extends StatefulWidget {
  final AuthenticationManager _authenticationManager = AuthenticationManager();
  final UserRepository _userRepository = UserRepository();
  final bool isSelf;
  UserPage({Key? key, required this.isSelf}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final Future<User> _userFuture;
  final List<String> _tabs = ['Activity', 'Library'];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _userFuture = widget._userRepository.getCurrentUser();
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
                // widget._authenticationManager.deleteUserToken();
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('You have been logged out')));
                // Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserSettings()));
              },
              icon: Icon(FeatherIcons.settings))
        ],
      ),
      body: FutureBuilder(
          future: _userFuture,
          builder: (context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasError)
              return Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.white),
              );
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  UserHeader(user: snapshot.data!),
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
              );
            }
            return Text(
              'Loading',
              style: TextStyle(color: Colors.white),
            );
          }),
    );
  }
}
