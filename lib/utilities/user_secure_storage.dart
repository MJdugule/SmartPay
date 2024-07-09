import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  static const _authKey = 'key';
  static const _cookies = 'cookies';
  static const _userId = 'userId';
  static const _pinKey = 'passPin';
  static const _passwordKey = 'passwordPin';

  static Future setUserCredentials(String token) async {
    await _storage.write(key: _authKey, value: token);
    // await _storage.write(key: _userId, value: userId);
  }

  static Future<String> getUserCredentials() async {
    String? authtoken = await _storage.read(key: _authKey) ?? '';

    return authtoken;
  }

  static Future setPinKey(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
  }

  static Future<String> getPinKey() async {
    String? token = await _storage.read(key: _pinKey) ?? '';
    return token.toString();
  }
  
  static Future setPasswordKey(String password) async {
    await _storage.write(key: _passwordKey, value: password);
  }

  static Future<String> getPasswordKey() async {
    String? token = await _storage.read(key: _passwordKey) ?? '';
    return token.toString();
  }

  static Future setAppCookies(String cookie) async {
    await _storage.write(key: _cookies, value: cookie);
  }

  static Future<String> getAppCookies() async {
    String? cooky = await _storage.read(key: _cookies) ?? '';
    return cooky.toString();
  }

  static Future<List<String>> getUserDetails() async {
    String? tokenId = await _storage.read(key: _authKey) ?? '';
    String? id = await _storage.read(key: _userId) ?? '';
    return [tokenId, id];
  }

  static Future deleteUserDetails() async {
    await _storage.delete(key: _authKey);
    await _storage.delete(key: _cookies);
    await _storage.delete(key: _pinKey);
    await _storage.delete(key: _passwordKey);
    await _storage.deleteAll();
  }

  static Future<String?> getAuthKey() async =>
      await _storage.read(key: _authKey);

  static Future<String?> getUserId() async => await _storage.read(key: _userId);
}
