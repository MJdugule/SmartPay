
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay/models/auth_user.dart';

class PrefUtils {
  static PrefUtils? _prefUtils;
  static SharedPreferences? _preferences;

//keys
  static const String userFirstTimeKey = 'first_time';
  static const String userThemeKey = 'pref_theme';
  static const String userLanguageKey = 'language';
  static const String emailKey = 'emails';
  static const String walletKey = 'wallet';
  static const String userDataKey = 'user_data';
  static const String userDetails = 'user_details';
  static const String notifing = 'notify';
  static const String admin = 'admin';
  static const String currentBusinessId = 'current_business_id';

  static Future<PrefUtils?> getInstance() async {
    if (_prefUtils == null) {
      // keep local instance till it is fully initialized.
      var prefStorage = PrefUtils._();
      await prefStorage._init();
      _prefUtils = prefStorage;
    }
    return _prefUtils;
  }

  PrefUtils._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool? getIsUserFirstTimeInApp() {
    if (_preferences == null) return false;
    return _preferences!.getBool(userFirstTimeKey);
  }

  static Future<bool>? putUserFirstTimeInApp(bool userFirstTime) {
    if (_preferences == null) return null;
    return _preferences!.setBool(userFirstTimeKey, userFirstTime);
  }

  static bool? getUserThemePreference() {
    if (_preferences == null) return false;
    return _preferences!.getBool(userThemeKey) ?? false;
  }

  static Future<bool>? saveUserThemePreference(bool userTheme) {
    if (_preferences == null) return null;
    return _preferences!.setBool(userThemeKey, userTheme);
  }

  static Future setUserData(String userData) async {
    await _preferences!.setString(userDetails, userData);
  }
  

  static AuthUser? getUserData() {
    if (_preferences == null) return null;
    String? authUser = _preferences!.getString(userDetails) ?? '';
    var userDecode = jsonDecode(authUser);
    var user = AuthUser.fromJson(userDecode);
    return user;
  }


  static void deleteUserFromMemory() {
    _preferences!.getKeys();
    for (String key in _preferences!.getKeys()) {
      if (key == userDataKey) {
        _preferences!.remove(key);
      }if (key == userDetails) {
        _preferences!.remove(key);
      }
     
    }
  }
}
