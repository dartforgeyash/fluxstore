import 'package:flutter/material.dart';
import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:fluxstore/widget/app_text.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final int activeIndex;
  final Function(int) onTap;
  final Widget? trailing;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.activeIndex,
    required this.onTap,
    this.trailing,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _keys = [];

  @override
  void initState() {
    super.initState();
    _updateKeys();
  }

  @override
  void didUpdateWidget(CustomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length != oldWidget.tabs.length) {
      _updateKeys();
    }
    if (widget.activeIndex != oldWidget.activeIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToIndex(widget.activeIndex);
      });
    }
  }

  void _updateKeys() {
    _keys.clear();
    for (int i = 0; i < widget.tabs.length; i++) {
      _keys.add(GlobalKey());
    }
  }

  void _scrollToIndex(int index) {
    if (index >= 0 && index < _keys.length) {
      final context = _keys[index].currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5, // Center the tab
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.hx,
      padding: EdgeInsets.symmetric(horizontal: 10.wx),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.tabs.length,
              itemBuilder: (context, index) {
                final isActive = widget.activeIndex == index;
                return InkWell(
                  key: _keys[index],
                  onTap: () => widget.onTap(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.wx,
                      vertical: 4.hx,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          widget.tabs[index],
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.kBlack,
                            fontWeight: isActive
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        4.verticalSpace,
                        if (isActive)
                          Container(
                            height: 2.hx,
                            width: 24.wx,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(2.rx),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (widget.trailing != null) ...[
            12.horizontalSpace,
            widget.trailing!,
          ],
        ],
      ),
    );
  }
}
