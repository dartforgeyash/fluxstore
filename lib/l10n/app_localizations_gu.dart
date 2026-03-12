// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get helloWorld => 'નમસ્તે દુનિયા';

  @override
  String get appName => 'ટ્રાન્સપોર્ટ એપ';

  @override
  String welcomeUser(String name) {
    return 'સ્વાગત છે, $name';
  }

  @override
  String get somethingWentWrong => 'કંઈક ખોટું થયું છે';

  @override
  String get selectLanguage => 'ભાષા પસંદ કરો';

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
