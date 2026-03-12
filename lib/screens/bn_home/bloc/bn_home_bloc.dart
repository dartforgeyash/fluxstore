import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/constant/images.dart';
import 'package:fluxstore/core/utils/shared_prefs_manager.dart';
import 'package:fluxstore/routes/app_routes.dart';
import 'package:fluxstore/screens/bn_home/bloc/bn_home_event.dart';
import 'package:fluxstore/screens/bn_home/bloc/bn_home_state.dart';
import 'package:fluxstore/screens/bn_home/models/exercise_model.dart';
import 'package:fluxstore/screens/bn_home/models/mood_model.dart';
import 'package:fluxstore/screens/bn_home/models/session_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedPreferenceManager _prefs;

  HomeBloc({SharedPreferenceManager? prefs})
    : _prefs = prefs ?? SharedPreferenceManager.instance,
      super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeMoodSelected>(_onMoodSelected);
    on<HomeMoodCleared>(_onMoodCleared);
    on<HomeBottomNavTapped>(_onBottomNavTapped);
    on<HomeNotificationTapped>(_onNotificationTapped);
    on<HomeExerciseTapped>(_onExerciseTapped);
    on<HomeFeaturedSessionTapped>(_onFeaturedSessionTapped);
  }

  // ── Static data ─────────────────────────────────────────────────────────────

  static const List<MoodModel> _moods = [
    MoodModel(
      type: MoodType.love,
      label: 'Love',
      imagePath: AppImages.feelingLove,
    ),
    MoodModel(
      type: MoodType.cool,
      label: 'Cool',
      imagePath: AppImages.feelingCool,
    ),
    MoodModel(
      type: MoodType.happy,
      label: 'Happy',
      imagePath: AppImages.feelingHappy,
    ),
    MoodModel(
      type: MoodType.sad,
      label: 'Sad',
      imagePath: AppImages.feelingSad,
    ),
  ];

  static const List<SessionModel> _sessions = [
    SessionModel(
      id: 'session_positive_vibes',
      title: 'Positive Vibes',
      description: 'Boost your mood with positive vibes',
      duration: '10 mins',
      illustrationPath: AppImages.walkingTheDog,
    ),
    SessionModel(
      id: 'session_stress_relief',
      title: 'Stress Relief',
      description: 'Calm your mind and ease your tension',
      duration: '15 mins',
      illustrationPath: AppImages.relaxationIcon,
    ),
    SessionModel(
      id: 'session_focus_boost',
      title: 'Focus Booster',
      description: 'Sharpen your attention and clarity',
      duration: '12 mins',
      illustrationPath: AppImages.meditationIcon,
    ),
  ];

  static final List<ExerciseModel> _exercises = [
    ExerciseModel(
      type: ExerciseType.relaxation,
      title: 'Relaxation',
      imagePath: AppImages.relaxationIcon,
      routeName: AppRoutes.relaxationScreen,
    ),
    ExerciseModel(
      type: ExerciseType.meditation,
      title: 'Meditation',
      imagePath: AppImages.meditationIcon,
      routeName: AppRoutes.meditationScreen,
    ),
    ExerciseModel(
      type: ExerciseType.breathing,
      title: 'Breathing',
      imagePath: AppImages.breathingIcon,
      routeName: AppRoutes.breathingScreen,
    ),
    ExerciseModel(
      type: ExerciseType.yoga,
      title: 'Yoga',
      imagePath: AppImages.yogaIcon,
      routeName: AppRoutes.yogaScreen,
    ),
  ];

  // ── Handlers ─────────────────────────────────────────────────────────────────

  Future<void> _onHomeStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final userName = _prefs.getUserName() ?? 'User';
      // Retrieve persisted today's mood (if any).
      final savedMoodIndex = _prefs.getTodayMoodIndex();
      final savedMood = savedMoodIndex != null && savedMoodIndex >= 0
          ? _moods[savedMoodIndex]
          : null;

      emit(
        HomeLoaded(
          userName: userName,
          moods: _moods,
          sessions: _sessions,
          exercises: _exercises,
          selectedMood: savedMood,
          currentNavIndex: 0,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onMoodSelected(
    HomeMoodSelected event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    // Persist today's mood locally.
    await _prefs.saveTodayMoodIndex(_moods.indexOf(event.mood));

    emit(current.copyWith(selectedMood: event.mood));
  }

  void _onMoodCleared(HomeMoodCleared event, Emitter<HomeState> emit) {
    final current = state;
    if (current is! HomeLoaded) return;
    if (current.selectedMood == null) return; // already clear — no-op
    emit(current.copyWith(clearMood: true));
  }

  void _onBottomNavTapped(HomeBottomNavTapped event, Emitter<HomeState> emit) {
    final current = state;
    if (current is! HomeLoaded) return;
    if (current.currentNavIndex == event.index) return;

    emit(current.copyWith(currentNavIndex: event.index));
  }

  void _onNotificationTapped(
    HomeNotificationTapped event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeNavigateTo(route: AppRoutes.notificationScreen));

    // Restore previous loaded state so the screen isn't disrupted.
    final current = state;
    if (current is HomeLoaded) emit(current);
  }

  void _onExerciseTapped(HomeExerciseTapped event, Emitter<HomeState> emit) {
    emit(HomeNavigateTo(route: event.exercise.routeName));

    final current = state;
    if (current is HomeLoaded) emit(current);
  }

  void _onFeaturedSessionTapped(
    HomeFeaturedSessionTapped event,
    Emitter<HomeState> emit,
  ) {
    emit(
      HomeNavigateTo(
        route: AppRoutes.sessionPlayerScreen,
        arguments: event.session,
      ),
    );

    final current = state;
    if (current is HomeLoaded) emit(current);
  }
}
