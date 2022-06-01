import 'package:anime/exceptions/storage_exception.dart';
import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/cookie/secure_storage_client.dart';

class AuthenticationManager {
  static final String USER_TOKEN_KEY = 'user_token_key';
  final SecureStorageClient _storageClient = SecureStorageClient();
  final ApiClient _apiClient = ApiClient();

  Future<bool> userIsLoggedIn() async {
    return await _storageClient.itemExist(USER_TOKEN_KEY);
  }

  void authenticateUserToken(String userToken) {
    try {
      _storageClient.setItem(USER_TOKEN_KEY, userToken);
    } on ItemNotSavedException {
      print('Error saving item');
    }
  }
}
