import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/screens/bn_home/models/mood_model.dart';

class MoodSelectorItem extends StatelessWidget {
  const MoodSelectorItem({
    super.key,
    required this.mood,
    required this.isSelected,
    required this.onTap,
    required this.onDeselect,
  });

  final MoodModel mood;
  final bool isSelected;
  final VoidCallback onTap;

  /// Called when the already-selected item is tapped again, or when the
  /// parent detects a tap outside the row. Clears the selection.
  final VoidCallback onDeselect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Re-tapping the active chip deselects it; tapping a new one selects it.
      onTap: isSelected ? onDeselect : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4CAF82).withOpacity(0.12)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4CAF82)
                : const Color(0xFFE8EDF2),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF4CAF82).withOpacity(0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: isSelected
                  ? AppColors.primary
                  : AppColors.buttonGrey,
              child: SvgPicture.asset(mood.imagePath, width: 38, height: 38),
            ),
            const SizedBox(height: 6),
            Text(
              mood.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? const Color(0xFF2E7D57)
                    : const Color(0xFF7B8CA0),
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
