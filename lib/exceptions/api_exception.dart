class ApiException implements Exception {
  final _message;
  final _prefix;
  ApiException(this._message, this._prefix);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends ApiException {
  FetchDataException([message])
      : super(message, 'Error during communication : ');
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, 'Invalid request : ');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([message]) : super(message, 'Unauthorized : ');
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException([message])
      : super(message, 'Internal server error : ');
}
