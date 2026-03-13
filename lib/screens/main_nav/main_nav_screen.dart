import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/constant/images.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:fluxstore/screens/bn_activities/bn_activities_tab.dart';
import 'package:fluxstore/screens/bn_home/bn_home_tab.dart';
import 'package:fluxstore/screens/bn_insights/bn_insights_tab.dart';
import 'package:fluxstore/screens/bn_my_account/bn_my_account_tab.dart';
import 'package:fluxstore/widget/common_image_view.dart';
import 'package:fluxstore/widget/common_scaffold.dart';
import 'package:fluxstore/widget/snackbar_widget.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  static Widget builder(BuildContext context) {
    return const MainNavScreen();
  }

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;
  DateTime? _lastPressedAt;

  final List<WidgetBuilder> _tabs = [
    HomeTab.builder,
    InsightsTab.builder,
    ActivitiesTab.builder,
    MyAccountTab.builder,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return;
        }

        final now = DateTime.now();
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          context.showInfo('Press back again to exit');

          // AppSnackBar.info(
          //   context: context,
          //   message: 'Press back again to exit',
          // );
          return;
        }

        SystemNavigator.pop();
      },
      child: CommonScaffold(
        body: _tabs[_selectedIndex](context),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.lightGrey, // separator color
                width: 1, // thickness
              ),
            ),
          ),
          child: BottomNavigationBar(
            selectedLabelStyle: AppTextStyles.small.copyWith(
              color: AppColors.primary,
            ),
            unselectedLabelStyle: AppTextStyles.small.copyWith(
              color: AppColors.grey,
            ),
            unselectedItemColor: AppColors.grey,
            selectedItemColor: AppColors.primary,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: navigationIcon(
                  imagePath: AppImages.bnNavHomeIcon,
                  iconColor: AppColors.grey,
                ),
                activeIcon: navigationIcon(
                  imagePath: AppImages.bnNavHomeIconSelected,
                  iconColor: AppColors.primary,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: navigationIcon(
                  imagePath: AppImages.bnNavInsightsIcon,
                  iconColor: AppColors.grey,
                ),
                activeIcon: navigationIcon(
                  imagePath: AppImages.bnNavInsightsIconSelected,
                  iconColor: AppColors.primary,
                ),
                label: 'Insights',
              ),
              BottomNavigationBarItem(
                icon: navigationIcon(
                  imagePath: AppImages.bnNavUserBarChartIcon,
                  iconColor: AppColors.grey,
                ),
                activeIcon: navigationIcon(
                  imagePath: AppImages.bnNavUserBarChartIcon,
                  iconColor: AppColors.primary,
                ),
                label: 'Activities',
              ),
              BottomNavigationBarItem(
                icon: navigationIcon(
                  imagePath: AppImages.bnAccountMenu,
                  iconColor: AppColors.grey,
                ),
                activeIcon: navigationIcon(
                  imagePath: AppImages.bnAccountMenu,
                  iconColor: AppColors.primary,
                ),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navigationIcon({required String imagePath, required Color iconColor}) {
    return CommonImageView(
      imagePath: imagePath,
      color: iconColor,
      source: ImageSource.asset,
      height: 18.hx,
      width: 18.hx,
    );
  }
}
