import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluxstore/constant/spacing.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:fluxstore/screens/bn_home/models/exercise_model.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
    this.backgroundColor,
  });

  final ExerciseModel exercise;
  final VoidCallback onTap;

  /// Per-card pastel background. Falls back to white if not provided.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              exercise.imagePath,
              width: 24.wx,
              height: 24.wx,
            ),
            Gaps.hGap(10),
            Flexible(
              child: Text(
                exercise.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.spx,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E3A2F),
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}