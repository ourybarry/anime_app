class StorageException implements Exception {
  final _message;
  final _prefix;
  StorageException(this._message, this._prefix);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class ItemNotFoundException extends StorageException {
  ItemNotFoundException([message]) : super(message, 'Inexisting key : ');
}

class ItemNotSavedException extends StorageException {
  ItemNotSavedException([message])
      : super(message, 'Error trying to save item : ');
}

class ItemNotDeletedException extends StorageException {
  ItemNotDeletedException([message])
      : super(message, 'Error trying to delete item : ');
}
