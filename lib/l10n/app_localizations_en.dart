// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World';

  @override
  String get appName => 'Transport App';

  @override
  String welcomeUser(String name) {
    return 'Welcome, $name';
  }

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get selectLanguage => 'Select Language';

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
