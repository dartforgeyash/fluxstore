import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:fluxstore/routes/app_routes.dart';
import 'package:fluxstore/screens/bn_insights/bloc/bn_insights_bloc.dart';
import 'package:fluxstore/screens/bn_insights/model/insights_models.dart';
import 'package:fluxstore/widget/common_image_view.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class InsightsTab extends StatefulWidget {
  const InsightsTab({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => InsightsBloc()..add(InsightsStarted()),
      child: const InsightsTab(),
    );
  }

  @override
  State<InsightsTab> createState() => _InsightsTabState();
}

class _InsightsTabState extends State<InsightsTab> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocConsumer<InsightsBloc, InsightsState>(
        listenWhen: (_, current) => current is InsightsNavigateTo,
        listener: (context, state) {
          if (state is InsightsNavigateTo) {
            Navigator.of(
              context,
            ).pushNamed(state.route, arguments: state.arguments);
          }
        },
        buildWhen: (_, current) =>
            current is InsightsLoading ||
            current is InsightsLoaded ||
            current is InsightsError,
        builder: (context, state) {
          if (state is InsightsLoading || state is InsightsInitial) {
            return Scaffold(
              backgroundColor: AppColors.white,
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.purple),
                ),
              ),
            );
          }
          if (state is InsightsError) {
            return Scaffold(
              backgroundColor: AppColors.grey,
              body: Center(child: Text(state.message)),
            );
          }
          if (state is InsightsLoaded) {
            return _buildLoaded(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, InsightsLoaded state) {
    final bloc = context.read<InsightsBloc>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── App bar ─────────────────────────────────────────────────────
            const _AliceCareAppBar(),
            const SizedBox(height: 14),

            // ── Search bar ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _SearchBar(
                controller: _searchCtrl,
                onChanged: (q) => bloc.add(InsightsSearchChanged(q)),
              ),
            ),
            const SizedBox(height: 16),

            // ── Category chips ───────────────────────────────────────────────
            _CategoryRow(
              categories: state.categories,
              selected: state.selectedCategory,
              onTap: (c) => bloc.add(InsightsCategoryChanged(c)),
            ),
            const SizedBox(height: 20),

            // ── Scrollable body ──────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hot topics
                    _SectionHeader(
                      title: 'Hot topics',
                      onSeeAll: () => bloc.add(
                        InsightsSeeAllTapped(AppRoutes.hotTopicsSeeAll),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _HotTopicsCarousel(
                      topics: state.hotTopics,
                      onTap: (t) => bloc.add(InsightsHotTopicTapped(t)),
                    ),
                    const SizedBox(height: 24),

                    // Get Tips
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Get Tips',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...state.tips.map(
                      (tip) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _TipCard(
                          tip: tip,
                          onAction: () =>
                              bloc.add(InsightsTipActionTapped(tip)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Cycle Phases
                    _SectionHeader(
                      title: 'Cycle Phases and Period',
                      onSeeAll: () => bloc.add(
                        InsightsSeeAllTapped(AppRoutes.cyclePhaseSeeAll),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _CyclePhaseList(phases: state.cyclePhases),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// App Bar
// ─────────────────────────────────────────────────────────────────────────────

class _AliceCareAppBar extends StatelessWidget {
  const _AliceCareAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Snowflake icon
          const Icon(Icons.ac_unit_rounded, color: AppColors.purple, size: 22),
          const SizedBox(width: 6),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Alice',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                    fontStyle: FontStyle.italic,
                    letterSpacing: -0.3,
                  ),
                ),
                TextSpan(
                  text: 'Care',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textDark,
                    fontStyle: FontStyle.italic,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Search Bar
// ─────────────────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8F0)),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14, color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: 'Articles, Video, Audio and More,...',
          hintStyle: const TextStyle(fontSize: 13, color: AppColors.textDark),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textDark,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category Row
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.categories,
    required this.selected,
    required this.onTap,
  });

  final List<CategoryTab> categories;
  final CategoryTab selected;
  final ValueChanged<CategoryTab> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final cat = categories[i];
          final isSelected = cat == selected;
          return GestureDetector(
            onTap: () => onTap(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.purple : AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.purple
                      : const Color(0xFFDDDDEE),
                ),
              ),
              child: Text(
                cat.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppColors.white : AppColors.textDark,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onSeeAll});

  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onSeeAll,
            child: Row(
              children: const [
                Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.purple,
                  ),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.purple,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Hot Topics Carousel
// ─────────────────────────────────────────────────────────────────────────────

class _HotTopicsCarousel extends StatelessWidget {
  const _HotTopicsCarousel({required this.topics, required this.onTap});

  final List<HotTopicModel> topics;
  final ValueChanged<HotTopicModel> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: topics.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) =>
            _HotTopicCard(topic: topics[i], onTap: () => onTap(topics[i])),
      ),
    );
  }
}

class _HotTopicCard extends StatelessWidget {
  const _HotTopicCard({required this.topic, required this.onTap});

  final HotTopicModel topic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.72;
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Image
            Image.network(
              topic.imageUrl,
              width: width,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: width,
                height: 180,
                color: const Color(0xFFEDD0E0),
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.purple,
                  size: 40,
                ),
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
            ),
            // Title
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Text(
                topic.title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tip Card
// ─────────────────────────────────────────────────────────────────────────────

class _TipCard extends StatelessWidget {
  const _TipCard({required this.tip, required this.onAction});

  final TipCardModel tip;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Doctor illustration
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            child: CommonImageView(
              imagePath: tip.imageUrl,
              source: ImageSource.asset,
              width: 110,
              height: 150,
              placeholder: Container(
                width: 110,
                height: 150,
                color: const Color(0xFFE8DEF8),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.purple,
                  size: 48,
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: 15.vh(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tip.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tip.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textDark,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: onAction,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text(
                        tip.actionLabel,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Cycle Phase List
// ─────────────────────────────────────────────────────────────────────────────

class _CyclePhaseList extends StatelessWidget {
  const _CyclePhaseList({required this.phases});

  final List<CyclePhaseModel> phases;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: phases.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => _CyclePhaseItem(phase: phases[i]),
    );
  }
}

class _CyclePhaseItem extends StatelessWidget {
  const _CyclePhaseItem({required this.phase});

  final CyclePhaseModel phase;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.purpleLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              color: AppColors.purple,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phase.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  phase.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textDark,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textDark,
            size: 20,
          ),
        ],
      ),
    );
  }
}
