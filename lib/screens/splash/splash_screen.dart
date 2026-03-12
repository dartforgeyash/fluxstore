import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/constant/images.dart';
// import 'package:fluxstore/core/utils/shared_prefs_manager.dart';
import 'package:fluxstore/routes/app_routes.dart';
import 'package:fluxstore/screens/splash/bloc/splash_bloc.dart';
import 'package:fluxstore/serices/navigation_service.dart';
import 'package:fluxstore/widget/common_image_view.dart';
import 'package:fluxstore/widget/common_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStarted()),
      child: const SplashScreen(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //final _prefs = SharedPreferenceManager.instance;
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            // if (_prefs.getUserToken()?.isNotEmpty == true) {
            //   NavigatorService.pushNamedAndRemoveUntil(AppRoutes.mainNavScreen);
            // } else {
            //   NavigatorService.pushNamedAndRemoveUntil(AppRoutes.loginScreen);
            // }
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.mainNavScreen);
          }
        },
        builder: (context, state) {
          return Center(
            child: CommonImageView(
              imagePath: AppImages.splashScreen,
              source: ImageSource.asset,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
