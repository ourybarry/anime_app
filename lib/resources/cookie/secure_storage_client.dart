//Helper class for saving and retrieving data to secure storage
import 'package:anime/exceptions/storage_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageClient {
  final _storage = new FlutterSecureStorage();

  Future<String> getItem(String itemKey) async {
    String? value = await _storage.read(key: itemKey);
    if (value == null) throw ItemNotFoundException();
    return value;
  }

  void setItem(String itemKey, String itemValue) async {
    await _storage
        .write(key: itemKey, value: itemValue)
        .catchError((error) => throw ItemNotSavedException(error));
  }

  Future<bool> itemExist(String itemKey) async {
    return await _storage.containsKey(key: itemKey);
  }
}
