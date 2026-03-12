import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/constant/images.dart';
import 'package:fluxstore/constant/spacing.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:fluxstore/screens/bn_home/models/session_model.dart';

class FeaturedSessionCard extends StatelessWidget {
  const FeaturedSessionCard({
    super.key,
    required this.session,
    required this.onPlayTap,
  });

  final SessionModel session;
  final VoidCallback onPlayTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 4.horizontalPadding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2E7D57), Color(0xFF4CAF82)],
        ),
        borderRadius: BorderRadius.circular(24.rx),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF82).withOpacity(0.35),
            blurRadius: 18.rx,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background decorative circles
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120.wx,
              height: 120.wx,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -30,
            child: Container(
              width: 90.wx,
              height: 90.wx,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          Padding(
            padding: 22.allPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        session.title,
                        style: TextStyle(
                          fontSize: 18.spx,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      Gaps.vGap(8),
                      Text(
                        session.description,
                        style: TextStyle(
                          fontSize: 12.spx,
                          color: Colors.white.withOpacity(0.80),
                          height: 1.4,
                        ),
                      ),
                      Gaps.vGap(16),
                      Row(
                        children: [
                          // Play button
                          GestureDetector(
                            onTap: onPlayTap,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                AppImages.playButtonGreen,
                                width: 34.wx,
                                height: 34.wx,
                              ),
                            ),
                          ),
                          Gaps.hGap(10),
                          // Duration chip
                          Container(
                            padding: 5.vh(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 12,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  session.duration,
                                  style: TextStyle(
                                    fontSize: 12.spx,
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Illustration
                SvgPicture.asset(
                  session.illustrationPath,
                  width: 105,
                  height: 105,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}