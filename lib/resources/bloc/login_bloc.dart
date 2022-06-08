import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/bloc/states/login_state.dart';
import 'package:anime/resources/model/user_token.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  late final BehaviorSubject<LoginState> _subject;
  late final ApiClient _apiClient;

  LoginBloc() {
    _subject = BehaviorSubject<LoginState>();
    _apiClient = ApiClient();
  }

  Stream<LoginState> get loginStream => _subject.stream;

  initLogin(String username, String password) async {
    _subject.add(LoginState.loading('Loading'));
    try {
      final result = await _apiClient
          .post('/auth/login', {'email': username, 'password': password});
      _subject.add(
          LoginState.completed('Login Success', UserToken.fromJson(result)));
    } catch (e) {
      _subject.add(LoginState.error(e.toString()));
    }
  }

  dispose() {
    _subject.close();
  }
}
