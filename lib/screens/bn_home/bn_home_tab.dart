import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/constant/images.dart';
import 'package:fluxstore/constant/spacing.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:fluxstore/routes/app_routes.dart';
import 'package:fluxstore/screens/bn_home/bloc/bn_home_bloc.dart';
import 'package:fluxstore/screens/bn_home/bloc/bn_home_event.dart';
import 'package:fluxstore/screens/bn_home/bloc/bn_home_state.dart';
import 'package:fluxstore/screens/bn_home/models/session_model.dart';
import 'package:fluxstore/screens/bn_home/widgets/exercise_card.dart';
import 'package:fluxstore/screens/bn_home/widgets/featured_session_card.dart';
import 'package:fluxstore/screens/bn_home/widgets/mood_selector_item.dart';
import 'package:fluxstore/serices/navigation_service.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeStarted()),
      child: const HomeTab(),
    );
  }

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final PageController _sessionPageController = PageController(
    viewportFraction: 0.88,
  );
  int _currentSessionPage = 0;

  @override
  void dispose() {
    _sessionPageController.dispose();
    super.dispose();
  }

  // ── Greeting helper ────────────────────────────────────────────────────────
  String _buildGreeting(String userName) {
    final hour = DateTime.now().hour;
    final timeGreeting = hour < 12
        ? 'Good Morning'
        : hour < 17
        ? 'Good Afternoon'
        : 'Good Evening';
    return '$timeGreeting, $userName';
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocConsumer<HomeBloc, HomeState>(
        /// One-shot navigation listener.
        listenWhen: (_, current) => current is HomeNavigateTo,
        listener: (context, state) {
          if (state is HomeNavigateTo) {
            NavigatorService.pushNamed(state.route, arguments: state.arguments);
          }
        },
        buildWhen: (prev, current) =>
            current is HomeLoading ||
            current is HomeLoaded ||
            current is HomeError,
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return _buildLoadingScaffold();
          }
          if (state is HomeError) {
            return _buildErrorScaffold(state.message);
          }
          if (state is HomeLoaded) {
            return _buildLoadedScaffold(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // ── Scaffold variants ──────────────────────────────────────────────────────

  Widget _buildLoadingScaffold() {
    return const Scaffold(
      backgroundColor: Color(0xFFF5FAF7),
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF82)),
        ),
      ),
    );
  }

  Widget _buildErrorScaffold(String message) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      body: Center(
        child: Padding(
          padding: 24.allPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: Color(0xFF4CAF82),
              ),
              Gaps.vGap(12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF7B8CA0), fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadedScaffold(BuildContext context, HomeLoaded state) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ────────────────────────────────────────────────────
            _HomeAppBar(
              onNotificationTap: () =>
                  context.read<HomeBloc>().add(HomeNotificationTapped()),
            ),

            // ── Scrollable content ─────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: 0.onlyPadding(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting
                    _GreetingSection(greeting: _buildGreeting(state.userName)),

                    // Mood selector
                    _SectionLabel(label: 'How are you feeling today?'),
                    _MoodSelectorRow(
                      moods: state.moods,
                      selectedMood: state.selectedMood,
                      onMoodTap: (mood) =>
                          context.read<HomeBloc>().add(HomeMoodSelected(mood)),
                      onMoodDeselect: () =>
                          context.read<HomeBloc>().add(HomeMoodCleared()),
                    ),

                    // Featured sessions carousel
                    _SectionLabel(
                      label: 'Featured Session',
                      trailingLabel: 'See all',
                      onTrailingTap: () => NavigatorService.pushNamed(
                        AppRoutes.activitiesScreen,
                      ),
                    ),
                    _FeaturedSessionCarousel(
                      sessions: state.sessions,
                      pageController: _sessionPageController,
                      currentPage: _currentSessionPage,
                      onPageChanged: (i) =>
                          setState(() => _currentSessionPage = i),
                      onSessionTap: (session) => context.read<HomeBloc>().add(
                        HomeFeaturedSessionTapped(session),
                      ),
                    ),

                    // Exercises grid
                    _SectionLabel(
                      label: 'Exercises',
                      trailingLabel: 'See all',
                      onTrailingTap: () => NavigatorService.pushNamed(
                        AppRoutes.activitiesScreen,
                      ),
                    ),
                    _ExerciseGrid(
                      exercises: state.exercises,
                      onExerciseTap: (exercise) => context.read<HomeBloc>().add(
                        HomeExerciseTapped(exercise),
                      ),
                    ),
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
// Private sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar({required this.onNotificationTap});

  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 14.vh(20),
      child: Row(
        children: [
          // Logo + app name
          SvgPicture.asset(AppImages.leafLogo, width: 32.wx, height: 32.wx),
          Gaps.hGap(8),
          Text(
            'Moody',
            style: TextStyle(
              fontSize: 22.spx,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E3A2F),
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          // Notification bell
          GestureDetector(
            onTap: onNotificationTap,
            child: Container(
              width: 42.wx,
              height: 42.wx,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.07),
                    blurRadius: 8.rx,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF1E3A2F),
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GreetingSection extends StatelessWidget {
  const _GreetingSection({required this.greeting});

  final String greeting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 0.vh(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: TextStyle(
              fontSize: 20.spx,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E3A2F),
              height: 1.2,
            ),
          ),
          Gaps.hGap(4),
          Text(
            'Take a moment to check in with yourself.',
            style: TextStyle(
              fontSize: 12.spx,
              color: Color(0xFF7B8CA0),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.label,
    this.trailingLabel,
    this.onTrailingTap,
  });

  final String label;
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 20.allPadding,
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.spx,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E3A2F),
            ),
          ),
          if (trailingLabel != null) ...[
            const Spacer(),
            GestureDetector(
              onTap: onTrailingTap,
              child: Row(
                children: [
                  Text(
                    trailingLabel!,
                    style: TextStyle(
                      fontSize: 13.spx,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4CAF82),
                    ),
                  ),
                  Gaps.hGap(2),
                  SvgPicture.asset(
                    AppImages.keyboardRightArrowGreen,
                    width: 14.wx,
                    height: 14.wx,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MoodSelectorRow extends StatelessWidget {
  const _MoodSelectorRow({
    required this.moods,
    required this.selectedMood,
    required this.onMoodTap,
    required this.onMoodDeselect,
  });

  final List moods;
  final dynamic selectedMood;
  final Function(dynamic) onMoodTap;
  final VoidCallback onMoodDeselect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: moods.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final mood = moods[index];
          return MoodSelectorItem(
            mood: mood,
            isSelected: selectedMood == mood,
            onTap: () => onMoodTap(mood),
            onDeselect: onMoodDeselect,
          );
        },
      ),
    );
  }
}

class _FeaturedSessionCarousel extends StatelessWidget {
  const _FeaturedSessionCarousel({
    required this.sessions,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
    required this.onSessionTap,
  });

  final List<SessionModel> sessions;
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<SessionModel> onSessionTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 135.hx,
          child: PageView.builder(
            controller: pageController,
            itemCount: sessions.length,
            onPageChanged: onPageChanged,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              return FeaturedSessionCard(
                session: sessions[index],
                onPlayTap: () => onSessionTap(sessions[index]),
              );
            },
          ),
        ),
        Gaps.vGap(12),
        // Dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            sessions.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: 0.vh(3),
              width: i == currentPage ? 20.wx : 7.wx,
              height: 7.wx,
              decoration: BoxDecoration(
                color: i == currentPage
                    ? const Color(0xFF4CAF82)
                    : const Color(0xFFB2DFCB),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExerciseGrid extends StatelessWidget {
  const _ExerciseGrid({required this.exercises, required this.onExerciseTap});

  final List exercises;
  final Function(dynamic) onExerciseTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 20.horizontalPadding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: exercises.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.7,
        ),
        itemBuilder: (_, index) {
          final exercise = exercises[index];
          return ExerciseCard(
            exercise: exercise,
            backgroundColor:
                AppColors.exerciseBgColors[(index %
                        AppColors.exerciseBgColors.length)
                    .toInt()],
            onTap: () => onExerciseTap(exercise),
          );
        },
      ),
    );
  }
}
