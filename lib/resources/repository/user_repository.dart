import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/authentication/authentication_manager.dart';
import 'package:anime/resources/model/user/user.dart';
import 'package:anime/resources/model/user_token.dart';

class UserRepository {
  final AuthenticationManager _authenticationManager = AuthenticationManager();

  final ApiClient _apiClient = ApiClient();

  Future<User> getCurrentUser() async {
    UserToken token = await _authenticationManager.getCurrentUserToken();
    final result = await _apiClient.get('/user/self',
        headers: {'Authorization': 'Bearer ${token.accessToken}'});
    print(result);
    return User.fromJson(result);
  }

  // Future<List<User>> getUsersByQuery(String query) {}
  // Future<User> getUserById(int id) {}
}
