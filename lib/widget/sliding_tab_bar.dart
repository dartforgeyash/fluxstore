import 'package:flutter/material.dart';
import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/constant/spacing.dart';

class SlidingTabBar extends StatelessWidget {
  final List<String> tabs;
  final int currentIndex;
  final Function(int) onTap;

  const SlidingTabBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.all(Corners.r8),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / tabs.length;

          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeInOutCubic,
                left: currentIndex * tabWidth,
                top: 0,
                bottom: 0,
                child: Container(
                  width: tabWidth,
                  decoration: BoxDecoration(
                    color: AppColors.tabGreen,
                    borderRadius: BorderRadius.all(Corners.r8),
                  ),
                ),
              ),
              Row(
                children: List.generate(tabs.length, (index) {
                  final isSelected = currentIndex == index;
                  return Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => onTap(index),
                      child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: AppTextStyles.label.copyWith(
                            color: isSelected
                                ? AppColors.kWhite
                                : AppColors.kBlack,
                            fontWeight: FontWeight.w600,
                          ),
                          child: Text(tabs[index]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
