import 'package:anime/exceptions/storage_exception.dart';
import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/cookie/secure_storage_client.dart';

class AuthenticationManager {
  static final String USER_TOKEN_KEY = 'user_token';
  final SecureStorageClient _storageClient = SecureStorageClient();
  final ApiClient _apiClient = ApiClient();

  Future<bool> userIsLoggedIn() async {
    // print('Checking for logged user');
    // print(_storageClient.getItem(USER_TOKEN_KEY));
    return await _storageClient.itemExist(USER_TOKEN_KEY);
  }

  void saveUserToken(String userToken) {
    try {
      _storageClient.setItem(USER_TOKEN_KEY, userToken);
    } on ItemNotSavedException {
      print('Error saving item');
    }
  }

  void deleteUserToken() {
    try {
      _storageClient.deleteItem(USER_TOKEN_KEY);
    } on ItemNotDeletedException {
      print('Error deleting item');
    }
  }
}
