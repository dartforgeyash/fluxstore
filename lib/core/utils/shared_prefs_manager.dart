import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  // Singleton instance of SharedPreferenceManager
  SharedPreferenceManager._privateConstructor();
  static final SharedPreferenceManager instance =
      SharedPreferenceManager._privateConstructor();

  // SharedPreferences object
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  // Initialize SharedPreferences
  Future<void> init() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  // Check if initialized
  void _checkInitialization() {
    if (!_isInitialized) {
      throw Exception(
        'SharedPreferenceManager not initialized. Call init() first.',
      );
    }
  }

  // ---- Keys ----
  static const String _onboardingKey = 'showOnboarding';
  static const String _userTokenKey = 'userToken';
  static const String _authTokenKey = 'authToken';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _authKey = 'authKey';

  // ++ New keys for Remember Me functionality
  static const String _rememberMeKey = 'rememberMe';
  static const String _rememberedMobileKey = 'rememberedMobile';
  static const String _rememberedPasswordKey = 'rememberedPassword';
  static const String _rulesLastShownDateKey =
      'rulesLastShownDate'; // For Daily check
  static const String _rulesPermanentlyHiddenKey =
      'rulesPermanentlyHidden'; // For Never show again
  static const String _keyUserName       = 'user_name';
  static const String _keyTodayMoodIndex = 'today_mood_index';
  static const String _keyMoodDate       = 'mood_date';
  // ---- Methods ----

  // Onboarding Screen
  Future<void> setOnboardingCompleted(bool value) async {
    _checkInitialization();
    await _prefs.setBool(_onboardingKey, value);
  }

  bool getOnboardingCompleted() {
    _checkInitialization();
    return _prefs.getBool(_onboardingKey) ?? false;
  }

  /// Persist the authenticated user's display name.
  Future<void> saveUserName(String name) async {
    await _prefs.setString(_keyUserName, name);
  }

  /// Retrieve the authenticated user's display name.
  String? getUserName() => _prefs.getString(_keyUserName);

  bool shouldShowRulesPopup() {
    _checkInitialization();

    bool isPermanentlyHidden =
        _prefs.getBool(_rulesPermanentlyHiddenKey) ?? false;
    if (isPermanentlyHidden) {
      return false;
    }

    String? lastDate = _prefs.getString(_rulesLastShownDateKey);
    String todayDate = DateTime.now().toIso8601String().split('T')[0];

    return lastDate != todayDate;
  }

  Future<void> setRulesSeen({required bool permanently}) async {
    _checkInitialization();

    if (permanently) {
      await _prefs.setBool(_rulesPermanentlyHiddenKey, true);
    } else {
      String todayDate = DateTime.now().toIso8601String().split('T')[0];
      await _prefs.setString(_rulesLastShownDateKey, todayDate);
    }
  }

  // Future<void> removeShowRulesPopup() async {
  //   await _prefs.remove(_rulesPopupDateKey);
  // }

  Future<void> setAuthKey(String key) async {
    _checkInitialization();
    if (_prefs.containsKey(_authKey)) {
      await _prefs.remove(_authKey);
    }
    await _prefs.setString(_authKey, key);
  }

  Future<void> removeAuthKey() async {
    _checkInitialization();
    await _prefs.remove(_authKey);
  }

  String? getAuthKey() {
    _checkInitialization();
    return _prefs.getString(_authKey);
  }

  // User Token Methods
  Future<void> setUserToken(String token) async {
    _checkInitialization();
    if (_prefs.containsKey(_userTokenKey)) {
      await _prefs.remove(_userTokenKey);
    }
    await _prefs.setString(_userTokenKey, token);
  }

  Future<void> removeUserToken() async {
    _checkInitialization();
    await _prefs.remove(_userTokenKey);
  }

  String? getUserToken() {
    _checkInitialization();
    return _prefs.getString(_userTokenKey);
  }

  Future<void> setRefreshToken(String token) async {
    _checkInitialization();
    if (_prefs.containsKey(_refreshTokenKey)) {
      await _prefs.remove(_refreshTokenKey);
    }
    await _prefs.setString(_refreshTokenKey, token);
  }

  Future<void> removeRefreshToken() async {
    _checkInitialization();
    await _prefs.remove(_refreshTokenKey);
  }

  String? getRefreshToken() {
    _checkInitialization();
    return _prefs.getString(_refreshTokenKey);
  }

  bool hasUserToken() {
    _checkInitialization();
    return _prefs.containsKey(_userTokenKey) &&
        _prefs.getString(_userTokenKey)?.isNotEmpty == true;
  }

  // Auth Token Methods
  Future<void> setAuthToken(String token) async {
    _checkInitialization();
    if (_prefs.containsKey(_authTokenKey)) {
      await _prefs.remove(_authTokenKey);
    }
    await _prefs.setString(_authTokenKey, token);
  }

  Future<void> removeAuthToken() async {
    _checkInitialization();
    await _prefs.remove(_authTokenKey);
  }

  String? getAuthToken() {
    _checkInitialization();
    return _prefs.getString(_authTokenKey);
  }

  bool hasAuthToken() {
    _checkInitialization();
    return _prefs.containsKey(_authTokenKey) &&
        _prefs.getString(_authTokenKey)?.isNotEmpty == true;
  }

  // ++ Methods for Remember Me functionality
  Future<void> setRememberMe(bool value) async {
    _checkInitialization();
    await _prefs.setBool(_rememberMeKey, value);
  }

  bool getRememberMe() {
    _checkInitialization();
    return _prefs.getBool(_rememberMeKey) ?? false;
  }

  Future<void> setRememberedCredentials(String mobile, String password) async {
    _checkInitialization();
    await _prefs.setString(_rememberedMobileKey, mobile);
    await _prefs.setString(_rememberedPasswordKey, password);
  }

  String? getRememberedMobile() {
    _checkInitialization();
    return _prefs.getString(_rememberedMobileKey);
  }

  String? getRememberedPassword() {
    _checkInitialization();
    return _prefs.getString(_rememberedPasswordKey);
  }

  Future<void> clearRememberedCredentials() async {
    _checkInitialization();
    await _prefs.remove(_rememberedMobileKey);
    await _prefs.remove(_rememberedPasswordKey);
  }

  // Logout functionality - Clear tokens but keep other data
  Future<void> logout() async {
    _checkInitialization();
    await _prefs.remove(_userTokenKey);
    await _prefs.remove(_authTokenKey);
    // Don't clear remember me data and onboarding status on logout
  }

  // Clear All except onboarding status
  Future<void> clearAllExceptOnboarding() async {
    _checkInitialization();
    bool onboardingStatus = getOnboardingCompleted();
    await _prefs.clear();
    await setOnboardingCompleted(onboardingStatus);
  }

  // Clear All
  Future<void> clearAll() async {
    _checkInitialization();
    await _prefs.clear();
  }

  // ── Mood persistence ─────────────────────────────────────────────────────────

  /// Save today's selected mood by its list index (0–3).
  /// Stores the current date to invalidate the entry the next day.
  Future<void> saveTodayMoodIndex(int index) async {
    final today = DateTime.now().toIso8601String().substring(0, 10); // yyyy-MM-dd
    await _prefs.setInt(_keyTodayMoodIndex, index);
    await _prefs.setString(_keyMoodDate, today);
  }

  /// Returns today's mood index, or null if no mood has been logged today.
  int? getTodayMoodIndex() {
    final savedDate = _prefs.getString(_keyMoodDate);
    final today = DateTime.now().toIso8601String().substring(0, 10);
    if (savedDate != today) return null; // mood is from a previous day
    return _prefs.getInt(_keyTodayMoodIndex);
  }
}
