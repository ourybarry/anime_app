import 'package:anime/resources/model/user_token.dart';

class LoginState {
  UserToken? token;
  String message; //Used to display error or loading message
  LoginStatus status;

  LoginState.loading(this.message) : status = LoginStatus.LOADING;
  LoginState.completed(this.message, this.token)
      : status = LoginStatus.COMPLETED;
  LoginState.error(this.message) : status = LoginStatus.ERROR;
}

enum LoginStatus { LOADING, COMPLETED, ERROR }
