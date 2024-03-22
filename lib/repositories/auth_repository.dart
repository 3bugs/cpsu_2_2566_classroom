import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/api_caller.dart';

class AuthRepository {
  static const keyToken = 'token';
  static const keyFullName = 'fullName';

  static final storage = FlutterSecureStorage();

  Future<void> login({
    required String username,
    required String password,
  }) async {
    var data = await ApiCaller().post(
      'login',
      params: {
        "username": username,
        "password": password,
      },
    );
    var map = jsonDecode(data);
    var token = map['token'];
    var fullName = map['user']['fullName'];
    _setToken(token);
    _setFullName(fullName);
  }

  Future<void> logout() async {
    _removeToken();
  }

  void _setToken(String token) {
    storage.write(key: keyToken, value: token);
  }

  void _setFullName(String fullName) {
    storage.write(key: keyFullName, value: fullName);
  }

  void _removeToken() {
    storage.delete(key: keyToken);
    storage.delete(key: keyFullName);
  }

  Future<String?> get token async => storage.read(key: keyToken);

  Future<String?> get fullName async => storage.read(key: keyFullName);
}
