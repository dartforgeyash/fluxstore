import 'package:flutter/material.dart';
import 'package:fluxstore/screens/breathing/breathing_screen.dart';
import 'package:fluxstore/screens/main_nav/main_nav_screen.dart';
import 'package:fluxstore/screens/meditation/meditation_screen.dart';
import 'package:fluxstore/screens/my_activities/my_activities_screen.dart';
import 'package:fluxstore/screens/relaxation/relaxation_screen.dart';
import 'package:fluxstore/screens/session_player/session_player_screen.dart';
import 'package:fluxstore/screens/splash/splash_screen.dart';
import 'package:fluxstore/screens/yoga/yoga_screen.dart';

class AppRoutes {
  ///Auth
  static const String signupScreen = '/signupScreen';
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/loginScreen';
  static const String otpVerifyScreen = '/otpVerifyScreen';
  static const String forgotPassPhoneScreen = '/forgotPassPhoneScreen';
  static const String forgotPassOtpScreen = '/forgotPassOtpScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String myProfileScreen = '/myProfileScreen';
  static const String depositScreen = '/depositScreen';
  static const String depositHistoryScreen = '/depositHistoryScreen';
  static const String withdrawHistoryScreen = '/withdrawHistoryScreen';
  static const String mainNavScreen = '/mainNavScreen';
  static const String withdrawRequestScreen = '/withdrawRequestScreen';
  static const String addScriptScreen = '/addScriptScreen';
  static const String chartScreen = '/chartScreen';
  static const String createOrderScreen = '/createOrderScreen';
  static const String accountDetailsScreen = '/accountDetailsScreen';
  static const String manageBankScreen = '/manageBankScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String tpSLScreen = '/tpSLScreen';
  static const String ledgerSummaryScreen = '/ledgerSummaryScreen';
  static const String rejectionLogsScreen = '/rejectionLogsScreen';
  static const String billDownloadScreen = '/billDownloadScreen';

  // ── Wellness ────────────────────────────────────────────────────────────────
  static const String activitiesScreen = '/activitiesScreen';
  static const String sessionPlayerScreen = '/sessionPlayerScreen';
  static const String relaxationScreen = '/relaxationScreen';
  static const String meditationScreen = '/meditationScreen';
  static const String breathingScreen = '/breathingScreen';
  static const String yogaScreen = '/yogaScreen';
  static const String insightsScreen = '/insightsScreen';

  static const String articleDetailScreen = '/articleDetailScreen';
  static const String doctorConnectScreen = '/doctorConnectScreen';
  static const String hotTopicsSeeAll     = '/hotTopicsSeeAll';
  static const String cyclePhaseSeeAll    = '/cyclePhaseSeeAll';

  static Map<String, WidgetBuilder> get routes => {
    ///PARENT
    // Uncomment and import the corresponding screen builders as they are
    // implemented. Follows the same pattern used in SplashScreen.builder.
    splashScreen: SplashScreen.builder,
    mainNavScreen: MainNavScreen.builder,

    // homeScreen:      HomeScreen.builder,
    // signupScreen:    SignUpScreen.builder,
    // loginScreen:     LoginScreen.builder,
    // otpVerifyScreen: OtpVerifyScreen.builder,

    // forgotPassPhoneScreen: ForgotPassPhoneScreen.builder,
    // forgotPassOtpScreen:   ForgotPassOtpScreen.builder,
    // resetPasswordScreen:   ResetPasswordScreen.builder,
    activitiesScreen: MyActivitiesScreen.builder,
    sessionPlayerScreen: SessionPlayerScreen.builder,
    relaxationScreen: RelaxationScreen.builder,
    meditationScreen: MeditationScreen.builder,
    breathingScreen: BreathingScreen.builder,
    yogaScreen: YogaScreen.builder,


    // articleDetailScreen: ArticleDetailScreen.builder,
    // doctorConnectScreen: DoctorConnectScreen.builder,

    // myProfileScreen:      MyProfileScreen.builder,
    // accountDetailsScreen: AccountDetailsScreen.builder,

    // depositScreen:         DepositScreen.builder,
    // depositHistoryScreen:  DepositHistoryScreen.builder,
    // withdrawHistoryScreen: WithdrawHistoryScreen.builder,
    // withdrawRequestScreen: WithdrawRequestScreen.builder,
    // manageBankScreen:      ManagePaymentMethodScreen.builder,
    // ledgerSummaryScreen:   LedgerSummaryScreen.builder,
    // rejectionLogsScreen:   RejectionLogsScreen.builder,
    // billDownloadScreen:    BillDownloadScreen.builder,

    // addScriptScreen:    AddScriptScreen.builder,
    // chartScreen:        ChartScreen.builder,
    // createOrderScreen:  CreateOrderScreen.builder,
    // tpSLScreen:         TpSLScreen.builder,
  };
}
