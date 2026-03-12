import 'package:flutter/material.dart';
import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/constant/spacing.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:fluxstore/widget/app_text.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final String selectedValue;
  final List<String> options;
  final ValueChanged<String> onSelected;
  final Color? bgColor;
  final Color? bgBorderColor;
  final TextStyle? labelStyle;
  final String? hint;
  final TextStyle? hintStyle;
  final TextStyle? selectedStyle;

  const CustomFilterChip({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onSelected,
    this.bgColor,
    this.bgBorderColor,
    this.labelStyle,
    this.hint,
    this.hintStyle,
    this.selectedStyle,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bool hasSelection = selectedValue.isNotEmpty;

    return PopupMenuButton<String>(
      onSelected: onSelected,
      color: isDarkMode ? AppColors.kBlack : AppColors.kWhite,
      itemBuilder: (BuildContext context) {
        return options.map((String choice) {
          return PopupMenuItem<String>(value: choice, child: Text(choice));
        }).toList();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            AppText(label, style: labelStyle ?? AppTextStyles.label),
          if (label.isNotEmpty) const SizedBox(height: 4),
          Container(
            padding: 12.vh(12),
            decoration: BoxDecoration(
              color: bgColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: bgBorderColor ?? Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Tooltip(
                    message: hasSelection ? selectedValue : (hint ?? ''),
                    child: Text(
                      hasSelection ? selectedValue : (hint ?? selectedValue),
                      style: hasSelection
                          ? (selectedStyle ?? AppTextStyles.small)
                          : hintStyle,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomExpandableFilterChip extends StatefulWidget {
  final String label;
  final String selectedValue;
  final bool hasValue;
  final List<String> options;
  final ValueChanged<String> onSelected;
  final Color? bgColor;
  final Color? bgBorderColor;
  final TextStyle? labelStyle;
  final String? hint;
  final TextStyle? hintStyle;
  final TextStyle? selectedStyle;

  const CustomExpandableFilterChip({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.hasValue,
    required this.options,
    required this.onSelected,
    this.bgColor,
    this.bgBorderColor,
    this.labelStyle,
    this.hint,
    this.hintStyle,
    this.selectedStyle,
  });

  @override
  State<CustomExpandableFilterChip> createState() =>
      _CustomExpandableFilterChipState();
}

class _CustomExpandableFilterChipState extends State<CustomExpandableFilterChip>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;

  static const double _itemHeight = 44.0;
  static const double _maxPanelHeight = 198.0;

  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    _isOpen = !_isOpen;
    _isOpen ? _controller.forward() : _controller.reverse();
  }

  void _select(String value) {
    _isOpen = false;
    _controller.reverse();
    widget.onSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bool hasSelection =
        widget.hasValue; // widget.selectedValue.isNotEmpty;

    final Color borderColor = isDarkMode
        ? const Color(0xFF3A3A3A)
        : const Color(0xFFDEDEDE);

    // Trigger bg: always #F5F5F5 light / #2C2C2C dark
    final Color triggerBg = isDarkMode
        ? const Color(0xFF2C2C2C)
        : const Color(0xFFF5F5F5);

    // Panel bg: white light / #1E1E1E dark — always distinct from trigger
    final Color panelBg = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;

    final double panelHeight = widget.options.isEmpty
        ? 0
        : (_itemHeight * widget.options.length).clamp(0, _maxPanelHeight);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        // bottom radius: 8→0 as panel opens
        final double bottomRadius = Tween<double>(
          begin: 8.0,
          end: 0.0,
        ).evaluate(_controller);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Label ────────────────────────────────────────────────────
            if (widget.label.isNotEmpty) ...[
              Text(
                widget.label,
                style:
                    widget.labelStyle ??
                    Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 4),
            ],

            // ── Trigger ───────────────────────────────────────────────────
            GestureDetector(
              onTap: widget.options.isEmpty ? null : _toggle,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: triggerBg,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(8),
                    topRight: const Radius.circular(8),
                    bottomLeft: Radius.circular(bottomRadius),
                    bottomRight: Radius.circular(bottomRadius),
                  ),
                  border: Border(
                    top: BorderSide(color: borderColor, width: 1),
                    left: BorderSide(color: borderColor, width: 1),
                    right: BorderSide(color: borderColor, width: 1),
                    // ── Always keep bottom border so trigger is never blank ──
                    // When open it acts as the separator between trigger and panel.
                    bottom: BorderSide(color: borderColor, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.selectedValue,
                        overflow: TextOverflow.ellipsis,
                        style: hasSelection
                            ? (widget.selectedStyle ??
                                  AppTextStyles.small.copyWith(
                                    color: isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF1A1A1A),
                                  ))
                            : (widget.hintStyle ??
                                  AppTextStyles.small.copyWith(
                                    color: isDarkMode
                                        ? const Color(0xFF8A8A8A)
                                        : const Color(0xFF9E9E9E),
                                  )),
                      ),
                    ),
                    const SizedBox(width: 6),
                    RotationTransition(
                      turns: _rotateAnimation,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: isDarkMode
                            ? const Color(0xFF8A8A8A)
                            : const Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Panel ─────────────────────────────────────────────────────
            SizeTransition(
              sizeFactor: _expandAnimation,
              axisAlignment: -1.0,
              child: Container(
                height: panelHeight,
                decoration: BoxDecoration(
                  color: panelBg,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: Border(
                    left: BorderSide(color: borderColor, width: 1),
                    right: BorderSide(color: borderColor, width: 1),
                    bottom: BorderSide(color: borderColor, width: 1),
                  ),
                  boxShadow: isDarkMode
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                ),
                // ✅ FIX 1: clipBehavior on the Container itself handles corner clipping.
                // ClipRRect is removed — it was not aligned with the border radius,
                // causing the square corner artifacts visible in the screenshot.
                clipBehavior: Clip.antiAlias,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.options.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    thickness: 0.8,
                    // ✅ FIX 2: indent/endIndent removed — full-width divider, no side gaps
                    color: isDarkMode
                        ? const Color(0xFF2C2C2C)
                        : const Color(0xFFF0F0F0),
                  ),
                  itemBuilder: (context, index) {
                    final option = widget.options[index];
                    final bool isSelected = option == widget.selectedValue;
                    return InkWell(
                      onTap: () => _select(option),
                      splashColor: AppColors.primary.withValues(alpha: 0.06),
                      highlightColor: AppColors.primary.withValues(alpha: 0.04),
                      child: Container(
                        height: _itemHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.centerLeft,
                        color: isSelected
                            ? (isDarkMode
                                  ? AppColors.primary.withValues(alpha: 0.15)
                                  : AppColors.primary.withValues(alpha: 0.06))
                            : Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: AppTextStyles.small.copyWith(
                                  color: isSelected
                                      ? AppColors.primary
                                      : (isDarkMode
                                            ? const Color(0xFFE0E0E0)
                                            : const Color(0xFF1A1A1A)),
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.check_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── SearchablePopupMenuButton ─────────────────────────────────────────────────
class SearchablePopupMenuButton<T> extends StatefulWidget {
  const SearchablePopupMenuButton({
    super.key,
    required this.items,
    required this.onSelected,
    this.selectedValue,
    this.label = '',
    this.hint = 'Search...',
    this.searchHint = 'Search...',
    this.popupWidth = 320,
    this.maxPopupHeight = 250,
    this.bgColor,
    this.bgBorderColor,
    this.labelStyle,
    this.hintStyle,
    this.selectedStyle,
  });

  final List<String> items;
  final ValueChanged<T> onSelected;
  final T? selectedValue;
  final String label;
  final String hint;
  final String searchHint;
  final double popupWidth;
  final double maxPopupHeight;

  // ── Theme overrides (mirrors CustomFilterChip API) ─────────────────────────
  final Color? bgColor;
  final Color? bgBorderColor;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? selectedStyle;

  @override
  State<SearchablePopupMenuButton<T>> createState() =>
      _SearchablePopupMenuButtonState<T>();
}

class _SearchablePopupMenuButtonState<T>
    extends State<SearchablePopupMenuButton<T>> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _searchCtrl = TextEditingController();
  OverlayEntry? _overlayEntry;
  List<String> _filtered = [];

  bool get _isOpen => _overlayEntry != null;

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  // ── Overlay lifecycle ───────────────────────────────────────────────────────

  void _openPopup() {
    _filtered = widget.items;
    _searchCtrl.clear();
    _overlayEntry = OverlayEntry(builder: (_) => _buildPopup());
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {});
  }

  void _closePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {});
    }
  }

  void _onSearch(String searchQuery) {
    final query = searchQuery.toLowerCase();
    _filtered = query.isEmpty
        ? widget.items
        : widget.items.where((v) => v.toLowerCase().contains(query)).toList();
    _overlayEntry?.markNeedsBuild();
  }

  // ── Popup overlay ───────────────────────────────────────────────────────────

  Widget _buildPopup() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    final popupBg = isDark ? AppColors.kBlack : AppColors.kWhite;

    return Stack(
      children: [
        // Dismiss barrier
        Positioned.fill(
          child: GestureDetector(
            onTap: _closePopup,
            behavior: HitTestBehavior.translucent,
          ),
        ),

        // Anchored popup
        CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, 52),
          showWhenUnlinked: false,
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(8),
              color: popupBg,
              child: SizedBox(
                width: widget.popupWidth.wx,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search field
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _searchCtrl,
                        autofocus: true,
                        onChanged: _onSearch,
                        style: AppTextStyles.label,
                        decoration: InputDecoration(
                          hintText: widget.searchHint,
                          hintStyle: TextStyle(
                            color: AppColors.textLight,
                            fontSize: 15.spx,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: const Icon(Icons.search, size: 18),
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.cardBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1.wx,
                              color: AppColors.border,
                            ),
                          ),
                          contentPadding: 10.verticalPadding,
                        ),
                      ),
                    ),

                    const Divider(height: 1),

                    // Items list
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: widget.maxPopupHeight.hx,
                      ),
                      child: _filtered.isEmpty
                          ? Padding(
                              padding: 20.allPadding,
                              child: Text(
                                'No results found',
                                style: AppTextStyles.label.copyWith(
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: 6.verticalPadding,
                              itemCount: _filtered.length,
                              itemBuilder: (_, i) {
                                final item = _filtered[i];
                                final selected = item == widget.selectedValue;
                                return InkWell(
                                  onTap: () {
                                    _closePopup();
                                    widget.onSelected(item as T);
                                  },
                                  child: Container(
                                    padding: 10.vh(14),
                                    color: selected
                                        ? cs.primaryContainer.withValues(
                                            alpha: 0.35,
                                          )
                                        : null,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item,
                                            style: AppTextStyles.label.copyWith(
                                              color: selected
                                                  ? cs.primary
                                                  : cs.onSurface,
                                              fontWeight: selected
                                                  ? FontWeight.w600
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        if (selected)
                                          Icon(
                                            Icons.check_rounded,
                                            size: 16,
                                            color: cs.primary,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Trigger button ──────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    final selectedLabel = widget.items
        .where((v) => v == widget.selectedValue)
        .firstOrNull;

    final bool hasSelection = selectedLabel != null;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _isOpen ? _closePopup : _openPopup,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Optional label ───────────────────────────────────────────────
            if (widget.label.isNotEmpty) ...[
              AppText(
                widget.label,
                style: widget.labelStyle ?? AppTextStyles.label,
              ),
              Gaps.vGap(4),
            ],

            // ── Trigger container ────────────────────────────────────────────
            Container(
              padding: 12.vh(12),
              decoration: BoxDecoration(
                color: widget.bgColor ?? Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.bgBorderColor ?? Colors.grey.shade300,
                  width: 1.wx,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Tooltip(
                      message: hasSelection ? selectedLabel : widget.hint,
                      child: Text(
                        hasSelection ? selectedLabel : widget.hint,
                        style: hasSelection
                            ? (widget.selectedStyle ?? AppTextStyles.small)
                            : (widget.hintStyle ??
                                  tt.bodyMedium?.copyWith(
                                    color: Colors.grey.shade500,
                                  )),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Gaps.hGap(6),
                  AnimatedRotation(
                    turns: _isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.grey,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
