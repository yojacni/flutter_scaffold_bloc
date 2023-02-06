import 'package:shared_preferences/shared_preferences.dart';

abstract class UserPreferencesManager {
  Future<bool> cleanAll();

  Future<int?> getUserId();

  Future<bool> setUserId(int newValue);

  Future<String> getAccessToken();

  Future<bool> setAccessToken(String newValue);

  Future<String> getTokenType();

  Future<bool> setTokenType(String newValue);

  Future<String> getRefreshToken();

  Future<bool> setRefreshToken(String newValue);

  Future<bool> getPersistAuth();

  Future<bool> setPersistAuth({required bool newValue});

  Future<bool> getFirstTime();

  Future<bool> setFirstTime({required bool newValue});
}

class SharedPreferencesImpl implements UserPreferencesManager {
  final _userId = 'user_id';

  final _accessToken = 'access_token';
  final _tokenType = 'tokenType';
  final _refreshToken = 'refresh_token';

  final _persisAuth = 'persist_auth';

  final _firstTime = 'first_time';

  @override
  Future<bool> cleanAll() async {
    await setUserId(0);
    await setAccessToken('');
    await setTokenType('');
    await setRefreshToken('');
    await setPersistAuth(newValue: false);
    return true;
  }

  @override
  Future<int?> getUserId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final value = sharedPrefs.getInt(_userId);
    return value;
  }

  @override
  Future<bool> setUserId(int newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final res = await sharedPrefs.setInt(_userId, newValue);
    return res;
  }

  @override
  Future<String> getAccessToken() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var value = sharedPrefs.getString(_accessToken);
    if (value == null) {
      value = '';
      await setAccessToken(value);
    }
    return value;
  }

  @override
  Future<bool> setAccessToken(String newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final res = sharedPrefs.setString(_accessToken, newValue);
    return res;
  }

  @override
  Future<String> getTokenType() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var value = sharedPrefs.getString(_tokenType);
    if (value == null) {
      value = '';
      await setAccessToken(value);
    }
    return value;
  }

  @override
  Future<bool> setTokenType(String newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final res = sharedPrefs.setString(_tokenType, newValue);
    return res;
  }

  @override
  Future<String> getRefreshToken() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var value = sharedPrefs.getString(_refreshToken);
    if (value == null) {
      value = '';
      await setAccessToken(value);
    }
    return value;
  }

  @override
  Future<bool> setRefreshToken(String newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final res = sharedPrefs.setString(_refreshToken, newValue);
    return res;
  }

  @override
  Future<bool> getPersistAuth() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var value = sharedPrefs.getBool(_persisAuth);
    if (value == null) {
      value = false;
      await setPersistAuth(newValue: value);
    }
    return value;
  }

  @override
  Future<bool> setPersistAuth({required bool newValue}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final res = sharedPrefs.setBool(_persisAuth, newValue);
    return res;
  }

  @override
  Future<bool> getFirstTime() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var value = sharedPrefs.getBool(_firstTime);
    if (value == null) {
      value = true;
      await setFirstTime(newValue: value);
    }
    return value;
  }

  @override
  Future<bool> setFirstTime({required bool newValue}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final res = sharedPrefs.setBool(_firstTime, newValue);
    return res;
  }
}
