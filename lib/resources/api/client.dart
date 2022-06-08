import 'dart:convert';
import 'dart:io';

import 'package:anime/exceptions/api_exception.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  //TODO: read api base url from .env
  final String _baseUrl = 'localhost:3000';

  Future<dynamic> get(String path,
      {Map<String, String>? params, Map<String, String>? headers}) async {
    final Uri uri = Uri.http(
      _baseUrl,
      '/api/v1' + path,
      params,
    );
    var _parsedResponse;
    try {
      final response = await http.get(uri, headers: headers);
      _parsedResponse = _parseResponse(response);
    } on SocketException {
      throw FetchDataException('No internet');
    }
    return _parsedResponse;
  }

  Future<dynamic> post(String path, Map<String, String> body) async {
    final Uri uri = Uri.http(_baseUrl, '/api/v1' + path);
    // print(uri.toString());
    var _parsedResponse;
    try {
      final response = await http.post(uri,
          body: json.encode(body),
          headers: {"Content-type": "application/json"});

      // print(json.encode(body));
      _parsedResponse = _parseResponse(response);
    } on SocketException {
      throw FetchDataException('No internet');
    }
    return _parsedResponse;
  }

  _parseResponse(http.Response response) {
    var _decodedResponse;
    switch (response.statusCode) {
      case HttpStatus.ok:
        _decodedResponse = jsonDecode(response.body);
        break;
      case HttpStatus.badRequest:
        throw BadRequestException(response.body.toString());
      case HttpStatus.unauthorized:
        throw UnauthorizedException(response.body.toString());
      case HttpStatus.internalServerError:
        throw InternalServerErrorException('Internal server error');
      default:
    }

    return _decodedResponse;
  }
}
