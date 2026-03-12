// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get helloWorld => 'नमस्ते दुनिया';

  @override
  String get appName => 'ट्रांसपोर्ट ऐप';

  @override
  String welcomeUser(String name) {
    return 'आपका स्वागत है, $name';
  }

  @override
  String get somethingWentWrong => 'कुछ गलत हो गया';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get welcome => 'Welcome';

  @override
  String get backFriend => 'Back, friend';

  @override
  String get signIn => 'SIGN IN';

  @override
  String get loginButton => 'LOG IN';

  @override
  String get errorInvalidCredentials => 'Invalid credential';

  @override
  String get loginSuccessMessage => 'Logged in successfully';
}
