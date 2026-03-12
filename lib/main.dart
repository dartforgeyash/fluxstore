import 'package:fluxstore/constant/const.dart';
import 'package:fluxstore/core/utils/shared_prefs_manager.dart';
import 'package:fluxstore/l10n/app_localizations.dart';
import 'package:fluxstore/routes/app_routes.dart';
// import 'package:fluxstore/serices/language_service.dart';
import 'package:fluxstore/serices/navigation_service.dart';
import 'package:fluxstore/theme/app_theme.dart';
import 'package:fluxstore/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final savedLocale = await LanguageService.getLanguage();
  await SharedPreferenceManager.instance.init();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeBloc())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, themeState) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (_, _) => MaterialApp(
            title: "Flex Store",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            // darkTheme: AppTheme.darkTheme,
            // // themeMode: themeState.themeMode,
            // themeMode: ThemeMode.light,
            navigatorObservers: [routeObserver],
            //locale: languageState?.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            navigatorKey: NavigatorService.navigatorKey,
            routes: AppRoutes.routes,
            initialRoute: AppRoutes.splashScreen,
          ),
        );
      },
    );
  }
}
