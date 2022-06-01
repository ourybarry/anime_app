import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/authentication/authentication_manager.dart';
import 'package:anime/resources/model/user_token.dart';
import 'package:anime/ui/pages/home.dart';
// import 'package:anime/resources/bloc/authentication_bloc.dart';
import 'package:anime/ui/themes/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class LoginPage extends StatefulWidget {
  // final AuthenticationBloc _authenticationBloc = AuthenticationBloc();
  final ApiClient _apiClient = ApiClient();
  final AuthenticationManager _authenticationManager = AuthenticationManager();
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                'Enter your kitsu credentials to login',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Username',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            icon: Icon(_hidePassword
                                ? FeatherIcons.eyeOff
                                : FeatherIcons.eye)),
                        hintText: 'Password',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return AlertDialog(
                          //         // backgroundColor: CustomColors.SURFACE_COLOR,

                          //         content: Text('Loading'),
                          //       );
                          //     });
                          _submitLoginData(_usernameController.text,
                              _passwordController.text);
                        },
                        child: Text('Login'),
                      ),
                      Text(
                        'Trouble with login',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  _submitLoginData(String username, String password) async {
    // print('$username, $password');
    try {
      final result = await widget._apiClient
          .post('/auth/login', {'username': username, 'password': password});
      // print(result);
      UserToken token = UserToken.fromJson(result);
      print(token.serialize());
      widget._authenticationManager.authenticateUserToken(token.serialize());
      Navigator.pop(context);
      // print(token.serialize());
    } catch (e) {
      print(e.toString());
    }
  }
}
