import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/authentication/authentication_manager.dart';
import 'package:anime/resources/bloc/login_bloc.dart';
import 'package:anime/resources/bloc/states/login_state.dart';
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
  // final ApiClient _apiClient = ApiClient();
  final LoginBloc _loginBloc = LoginBloc();
  final AuthenticationManager _authenticationManager = AuthenticationManager();
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hasError = false;
  String _error = '';

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(FeatherIcons.x)),
      ),
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
                      errorStyle: TextStyle(color: Colors.red),
                      // errorText: 'Incorrect credentials',
                      errorText: _hasError ? _error : null,
                      hintText: 'Username',
                    ),
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
                        errorText: _hasError ? '' : null),
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
                          widget._loginBloc.initLogin(_usernameController.text,
                              _passwordController.text);
                          widget._loginBloc.loginStream
                              .listen((LoginState event) {
                            // print(event.status);
                            switch (event.status) {
                              case LoginStatus.LOADING:
                                _showLoadingDialog();
                                break;
                              case LoginStatus.ERROR:
                                _showError(event.message);
                                break;
                              case LoginStatus.COMPLETED:
                                // print(event.token);
                                _redirect(event.token!);
                                break;
                              default:
                            }
                          });
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

  _showLoadingDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // backgroundColor: CustomColors.SURFACE_COLOR,

            content: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                  width: 40, height: 40, child: CircularProgressIndicator()),
            ]),
          );
        });
  }

  _showError(String error) {
    Navigator.pop(context); //Dismiss alert dialog
    setState(() {
      _hasError = true;
      _error = error;
    });
  }

  _redirect(UserToken token) {
    try {
      widget._authenticationManager.saveUserToken(token.serialize().toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You are logged in')));
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    }
  }
  // _submitLoginData(String username, String password) async {
  //   // print('$username, $password');
  //   try {
  //     final result = await widget._apiClient
  //         .post('/auth/login', {'username': username, 'password': password});
  //     // print(result);
  //     UserToken token = UserToken.fromJson(result);
  //     print(token.serialize());
  //     widget._authenticationManager.saveUserToken(token.serialize().toString());
  //     Navigator.pop(context);
  //     // print(token.serialize());
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
