import 'package:anime/ui/pages/authentication/login.dart';
import 'package:anime/ui/pages/home.dart';
import 'package:anime/ui/pages/notifications.dart';
import 'package:anime/ui/pages/search/search.dart';
import 'package:anime/ui/pages/user/user_home.dart';
import 'package:anime/ui/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: DarkTheme.theme,
      // builder: EasyLoading.init(),
    );
  }
}

class Home extends StatefulWidget {
  final pages = [HomePage(), SearchPage(), SearchPage()];

  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    // currentPage = 0; TODO:
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo/fire_logo.png',
          width: 20,
        ),
        elevation: 0,
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const Notifications()));
          //     },
          //     icon: Icon(Icons.notifications)),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
            child: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: const Text('AB'),
                maxRadius: 15),
          ),
        ],
      ),
      body: Center(
          child: Container(
              padding: const EdgeInsets.all(10),
              child: widget.pages.elementAt(currentPage))),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.my_library_books), label: 'Collection')
          ],
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          }),
    );
  }
}
