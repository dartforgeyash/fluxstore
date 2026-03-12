import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/constant/images.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:fluxstore/core/utils/shared_prefs_manager.dart';
import 'package:fluxstore/routes/app_routes.dart';
import 'package:fluxstore/screens/bn_my_account/bloc/my_account_bloc.dart';
import 'package:fluxstore/screens/bn_my_account/bloc/my_account_event.dart';
import 'package:fluxstore/screens/bn_my_account/bloc/my_account_state.dart';
import 'package:fluxstore/serices/navigation_service.dart';
import 'package:fluxstore/theme/theme_bloc.dart';
import 'package:fluxstore/widget/app_button.dart';
import 'package:fluxstore/widget/app_text.dart';
import 'package:fluxstore/widget/app_text_rich.dart';
import 'package:fluxstore/widget/common_app_bar.dart';
import 'package:fluxstore/widget/common_image_view.dart';
import 'package:fluxstore/widget/common_scaffold.dart';

class MyAccountTab extends StatefulWidget {
  const MyAccountTab({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc()
        ..add(AccountStarted())
        ..add(LoadAppVersionEvent()),
      child: const MyAccountTab(),
    );
  }

  @override
  State<MyAccountTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MyAccountTab> {
  final _prefs = SharedPreferenceManager.instance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return CommonScaffold(
          appBar: CommonAppBar(
            title: "My Account",
            actions: [
              GestureDetector(
                onTap: () async {
                  await NavigatorService.pushNamed(AppRoutes.myProfileScreen);
                  if (context.mounted) {
                    context.read<AccountBloc>().add(AccountProfileRefresh());
                  }
                },
                child:
                    // (state.profile?.profileImage != null &&
                    //     state.profile!.profileImage!.isNotEmpty)
                    // ? CircleAvatar(
                    //     radius: 14.hx,
                    //     backgroundColor: AppColors.lightGrey,
                    //     child: ClipOval(
                    //       child: Image.network(
                    //         state.profile!.profileImage!,
                    //         width: 28.hx,
                    //         height: 28.hx,
                    //         fit: BoxFit.cover,
                    //         errorBuilder: (_, _, _) => Container(
                    //           width: 28.hx,
                    //           height: 28.hx,
                    //           color: AppColors.lightGrey,
                    //           alignment: Alignment.center,
                    //           child: Text(
                    //             (state.profile?.name?.isNotEmpty == true)
                    //                 ? state.profile!.name![0].toUpperCase()
                    //                 : '?',
                    //             style: TextStyle(
                    //               fontSize: 12.spx,
                    //               fontWeight: FontWeight.w700,
                    //               color: AppColors.kBlack,
                    //             ),
                    //           ),
                    //         ),
                    //         loadingBuilder: (_, child, progress) =>
                    //             progress == null
                    //             ? child
                    //             : SizedBox(
                    //                 width: 28.hx,
                    //                 height: 28.hx,
                    //                 child: const Center(
                    //                   child: CircularProgressIndicator(
                    //                     strokeWidth: 1.5,
                    //                     color: AppColors.primary,
                    //                   ),
                    //                 ),
                    //               ),
                    //       ),
                    //     ),
                    //   )
                    // :
                    CircleAvatar(
                      radius: 14.hx,
                      backgroundColor: const Color(0xFFE1E1E1),
                      child: CommonImageView(
                        imagePath: AppImages.userName,
                        source: ImageSource.asset,
                        color: AppColors.kBlack,
                        padding: 1.allPadding,
                      ),
                    ),
              ),
              18.horizontalSpace,
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _balanceCard(state),
              Divider(color: AppColors.divider, height: 1),
              8.verticalSpace,
              Expanded(
                child: AnimationLimiter(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 200),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 20.0,
                        child: FadeInAnimation(child: widget),
                      ),
                      children: [
                        _sectionTitle('Account Details', theme),
                        12.verticalSpace,
                        _buildMenuGroup(context, isDarkMode, [
                          _buildMenuTile(
                            context: context,
                            icon: AppImages.menuAccountDetails,
                            title: 'Account Details',
                            onTap: () {
                              NavigatorService.pushNamed(
                                AppRoutes.accountDetailsScreen,
                              );
                            },
                          ),
                          _buildMenuTile(
                            context: context,
                            icon: AppImages.menuViewStatement,
                            title: 'Ledger Summary',
                            onTap: () {
                              NavigatorService.pushNamed(
                                AppRoutes.ledgerSummaryScreen,
                              );
                            },
                          ),
                          _buildMenuTile(
                            context: context,
                            icon: AppImages.menuRejectionLogs,
                            title: 'Rejection Logs',
                            onTap: () {
                              NavigatorService.pushNamed(
                                AppRoutes.rejectionLogsScreen,
                              );
                            },
                          ),
                          _buildMenuTile(
                            context: context,
                            icon: AppImages.menuBillDownload,
                            title: 'Bill Download',
                            onTap: () {
                              NavigatorService.pushNamed(
                                AppRoutes.billDownloadScreen,
                              );
                            },
                          ),
                        ]),
                        20.verticalSpace,

                        _sectionTitle('Bank & Transactions', theme),
                        12.verticalSpace,
                        _buildMenuGroup(context, isDarkMode, [
                          _buildMenuTile(
                            context: context,
                            icon: AppImages.menuBillDownload,
                            title: 'Manage Bank/UPI',
                            onTap: () {
                              NavigatorService.pushNamed(
                                AppRoutes.manageBankScreen,
                              );
                            },
                          ),
                          _buildMenuTile(
                            context: context,
                            icon: AppImages.menuBillDownload,
                            title: 'Deposit History',
                            onTap: () => NavigatorService.pushNamed(
                              AppRoutes.depositHistoryScreen,
                            ),
                          ),
                          _buildMenuTile(
                            context: context,
                            icon: AppImages.menuBillDownload,
                            title: 'Withdraw History',
                            onTap: () => NavigatorService.pushNamed(
                              AppRoutes.withdrawHistoryScreen,
                            ),
                          ),
                        ]),
                        20.verticalSpace,
                        // _sectionTitle('Theme', theme),
                        // 12.verticalSpace,
                        // BlocBuilder<ThemeBloc, ThemeData>(
                        //   builder: (context, state) {
                        //     final currentPref = context
                        //         .read<ThemeBloc>()
                        //         .currentPreference;
                        //
                        //     return _buildMenuGroup(context, isDarkMode, [
                        //       ThemeSelectorCard(),
                        //     ]);
                        //   },
                        // ),
                        // 12.verticalSpace,
                        AppText(
                          'Version v${state.appVersion}',
                          style: AppTextStyles.small,
                        ),
                        30.verticalSpace,

                        // Logout Button with improved styling
                        Center(
                          child: OutlinedButton.icon(
                            icon: const Icon(
                              Icons.logout_rounded,
                              color: AppColors.brickRed,
                            ),
                            label: AppText(
                              'Logout',
                              style: AppTextStyles.title.copyWith(
                                color: AppColors.brickRed,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.brickRed.withValues(
                                alpha: .1,
                              ),
                              side: const BorderSide(color: AppColors.brickRed),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 14,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              logoutDialog(
                                context: context,
                                isDark: isDarkMode,
                              );
                            },
                          ),
                        ),

                        20.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String selected2FA = "Phone"; // you can move this to Bloc later

  Widget _balanceCard(AccountState state) {
    // final balance = state.livePnLPrice;
    return Padding(
      padding: 20.allPadding,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT SIDE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  "Available Balance",
                  style: AppTextStyles.label.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                10.verticalSpace,
                AppText("10,000.00", style: AppTextStyles.heading1),
                // AppText(balance, style: AppTextStyles.heading1),
                8.verticalSpace,
                AppRichText(
                  overflow: TextOverflow.ellipsis,
                  items: [
                    TextSpanItem(
                      text: "Today's PnL: ",
                      style: AppTextStyles.small,
                    ),
                    TextSpanItem(
                      text: state.livePnLPrice ?? "0.00",
                      style: AppTextStyles.small.copyWith(
                        color: AppColors.getPnlColor(
                          double.tryParse(state.livePnLPrice ?? "0.00") ?? 0,
                        ),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// RIGHT SIDE BUTTONS
          Column(
            children: [
              _actionButton(
                title: "Deposit",
                color: AppColors.primary,
                onTap: () {
                  NavigatorService.pushNamed(AppRoutes.depositScreen);
                },
              ),
              8.verticalSpace,

              _actionButton(
                title: "Withdraw",
                color: Color(0xFFF5F5F5),
                textColor: Colors.black,
                onTap: () {
                  NavigatorService.pushNamed(AppRoutes.withdrawRequestScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String title,
    required Color color,
    Color textColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 130,
      //height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          textStyle: AppTextStyles.title,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onTap,
        child: Text(title),
      ),
    );
  }

  Future<bool> logoutDialog({
    required BuildContext context,
    required bool isDark,
  }) async {
    final result = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: "logout",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: 0.9 + (0.1 * anim1.value),
          child: Opacity(
            opacity: anim1.value,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 28,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.kDarkMode : AppColors.kWhite,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kBlack.withAlpha(20),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: AppColors.brickRed,
                        size: 48,
                      ),
                      20.verticalSpace,
                      AppText(
                        "Are you sure you want to log out? You’ll need to sign in again to continue.",
                        align: TextAlign.center,
                        style: AppTextStyles.label,
                      ),
                      24.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              title: "Cancel",
                              isSecondary: true,
                              onPressed: () {
                                NavigatorService.goBack();
                              },
                            ),
                          ),
                          12.horizontalSpace,
                          Expanded(
                            child: AppButton(
                              title: "Logout",
                              onPressed: () {
                                _prefs.removeUserToken();
                                NavigatorService.pushNamedAndRemoveUntil(
                                  AppRoutes.loginScreen,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    return result ?? false;
  }
}

// A more prominent section title style
Widget _sectionTitle(String title, ThemeData theme) {
  return AppText(
    title,
    style: AppTextStyles.label.copyWith(fontWeight: FontWeight.bold),
  );
}

Widget _buildMenuGroup(
  BuildContext context,
  bool isDarkMode,
  List<Widget> tiles,
) {
  return Column(children: tiles);
}

// REFACTORED: The menu tile now uses theme colors and is designed to sit inside a group
Widget _buildMenuTile({
  required BuildContext context,
  required String icon,
  required String title,
  GestureTapCallback? onTap,
}) {
  Theme.of(context);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ListTile(
        contentPadding: 0.vh(10),
        dense: true,
        leading: Container(
          height: 32.wx,
          width: 32.wx,
          padding: 6.allPadding,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: CommonImageView(
            imagePath: icon,
            height: 20.wx,
            width: 20.wx,
            source: ImageSource.asset,
          ),
        ),
        title: AppText(
          title,
          style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w500),
        ),
        trailing: onTap != null
            ? Icon(
                Icons.chevron_right,
                color: AppColors.primary.withValues(alpha: 0.7),
              )
            : null,
        onTap: onTap,
        splashColor: AppColors.primary.withValues(alpha: 0.1),
        hoverColor: AppColors.primary.withValues(alpha: 0.05),
      ),
      // Add a divider between items, but not for the last one
    ],
  );
}

class ThemeSelectorCard extends StatefulWidget {
  const ThemeSelectorCard({super.key});

  @override
  State<ThemeSelectorCard> createState() => _ThemeSelectorCardState();
}

class _ThemeSelectorCardState extends State<ThemeSelectorCard> {
  ThemePreference? _localPref;

  @override
  void initState() {
    super.initState();
    _localPref = context.read<ThemeBloc>().currentPreference;
  }

  void _openThemeSheet() {
    _showThemeSelectionSheet(
      context,
      onThemeSelected: (pref) {
        setState(() {
          _localPref = pref; // update immediately for UI
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openThemeSheet,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(Icons.color_lens_outlined, color: AppColors.primary),
              16.verticalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      _getThemeDisplayName(_localPref!),
                      style: AppTextStyles.label,
                    ),
                    const SizedBox(height: 2),
                    AppText(
                      "Tap to change",
                      style: AppTextStyles.small.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}

// Modified _showThemeSelectionSheet to accept callback
void _showThemeSelectionSheet(
  BuildContext context, {
  void Function(ThemePreference)? onThemeSelected,
}) {
  ThemePreference currentTheme = context.read<ThemeBloc>().currentPreference;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (modalContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.45,
            minChildSize: 0.2,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return Column(
                children: [
                  12.verticalSpace,
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  16.verticalSpace,
                  AppText("Choose Theme", style: AppTextStyles.title),
                  16.verticalSpace,
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: ThemePreference.values.length,
                      separatorBuilder: (_, _) =>
                          const Divider(height: 1, indent: 20, endIndent: 20),
                      itemBuilder: (context, index) {
                        final theme = ThemePreference.values[index];
                        final isSelected = theme == currentTheme;

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                currentTheme = theme;
                              });

                              context.read<ThemeBloc>().setThemePreference(
                                theme,
                              );

                              // Callback to parent
                              onThemeSelected?.call(theme);

                              // Future.delayed(
                              //   const Duration(milliseconds: 300),
                              //       () {
                              //     if (context.mounted) {
                              //       Navigator.pop(context);
                              //     }
                              //   },
                              // );
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary.withValues(alpha: 0.12)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: isSelected
                                    ? Border.all(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.3,
                                        ),
                                        width: 1,
                                      )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary.withValues(
                                              alpha: 0.15,
                                            )
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      _getThemeIcon(theme),
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.grey,
                                      size: 20,
                                    ),
                                  ),
                                  16.verticalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AnimatedDefaultTextStyle(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                                color: isSelected
                                                    ? AppColors.primary
                                                    : null,
                                              ),
                                          child: Text(
                                            _getThemeDisplayName(theme),
                                          ),
                                        ),
                                        if (isSelected) ...[
                                          const SizedBox(height: 2),
                                          Text(
                                            "Currently active",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: AppColors.primary
                                                      .withValues(alpha: 0.7),
                                                  fontSize: 11,
                                                ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  AnimatedScale(
                                    duration: const Duration(milliseconds: 300),
                                    scale: isSelected ? 1.0 : 0.0,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  16.verticalSpace,
                ],
              );
            },
          );
        },
      );
    },
  );
}

// Helper methods remain same
IconData _getThemeIcon(ThemePreference theme) {
  switch (theme) {
    case ThemePreference.light:
      return Icons.light_mode_outlined;
    case ThemePreference.dark:
      return Icons.dark_mode_outlined;
    case ThemePreference.system:
      return Icons.settings_system_daydream_outlined;
  }
}

String _getThemeDisplayName(ThemePreference theme) {
  switch (theme) {
    case ThemePreference.light:
      return "Light Theme";
    case ThemePreference.dark:
      return "Dark Theme";
    case ThemePreference.system:
      return "System Default";
  }
}
