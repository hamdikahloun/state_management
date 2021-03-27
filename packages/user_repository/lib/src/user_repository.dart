import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  static final UserRepository _singleton = UserRepository._internal();

  /// User Repository
  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal();

  final http.Client httpClient = http.Client();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _securedToken = 'SECURED_TOKEN';
  final String _baseUrl = '60585b2ec3f49200173adcec.mockapi.io';

  /// Login and return the token that should be saved for future requests.
  Future<String?> authenticate({
    required String username,
    required String password,
  }) async {
    final response = await httpClient.post(
      Uri.https(
          _baseUrl, '/api/v1/login', {"email": username, "password": password}),
    );

    if (response.statusCode == 201) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      return body['token'] as String;
    }
    throw Exception('error login');
  }

  /// Delete Token
  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _securedToken);
    } catch (e) {
      print('deleteToken: $e');
    }
    return;
  }

  /// Encrypts and saves the Token.
  Future<void> persistToken(String token) async {
    try {
      await _storage.write(key: _securedToken, value: token);
    } catch (e) {
      print('persistToken: $e');
    }
    return;
  }

  /// Decrypts and returns the token or null if token is not in the storage.
  Future<String?> readToken() async {
    try {
      return _storage.read(key: _securedToken);
    } catch (e) {
      print('readToken: $e');
    }
    return null;
  }
}
