import 'package:equatable/equatable.dart';
import 'package:fluxstore/screens/bn_home/models/exercise_model.dart';
import 'package:fluxstore/screens/bn_home/models/mood_model.dart';
import 'package:fluxstore/screens/bn_home/models/session_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Fired once when the screen mounts to load initial data.
class HomeStarted extends HomeEvent {}

/// Fired when the user taps a mood chip.
class HomeMoodSelected extends HomeEvent {
  final MoodModel mood;
  const HomeMoodSelected(this.mood);

  @override
  List<Object?> get props => [mood];
}

/// Fired when the user taps outside the mood row or re-taps the active chip.
class HomeMoodCleared extends HomeEvent {}

/// Fired when a bottom-nav tab is tapped.
class HomeBottomNavTapped extends HomeEvent {
  final int index;
  const HomeBottomNavTapped(this.index);

  @override
  List<Object?> get props => [index];
}

/// Fired when the notification bell is tapped.
class HomeNotificationTapped extends HomeEvent {}

/// Fired when an exercise card is tapped.
class HomeExerciseTapped extends HomeEvent {
  final ExerciseModel exercise;
  const HomeExerciseTapped(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

/// Fired when a featured session play-button / card is tapped.
class HomeFeaturedSessionTapped extends HomeEvent {
  final SessionModel session;
  const HomeFeaturedSessionTapped(this.session);

  @override
  List<Object?> get props => [session];
}
