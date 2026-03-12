import 'package:equatable/equatable.dart';
import 'package:fluxstore/screens/bn_home/models/exercise_model.dart';
import 'package:fluxstore/screens/bn_home/models/mood_model.dart';
import 'package:fluxstore/screens/bn_home/models/session_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String userName;
  final List<MoodModel> moods;
  final List<SessionModel> sessions;
  final List<ExerciseModel> exercises;
  final MoodModel? selectedMood;
  final int currentNavIndex;

  const HomeLoaded({
    required this.userName,
    required this.moods,
    required this.sessions,
    required this.exercises,
    this.selectedMood,
    required this.currentNavIndex,
  });

  HomeLoaded copyWith({
    String? userName,
    List<MoodModel>? moods,
    List<SessionModel>? sessions,
    List<ExerciseModel>? exercises,
    MoodModel? selectedMood,
    int? currentNavIndex,
    bool clearMood = false,
  }) {
    return HomeLoaded(
      userName: userName ?? this.userName,
      moods: moods ?? this.moods,
      sessions: sessions ?? this.sessions,
      exercises: exercises ?? this.exercises,
      selectedMood: clearMood ? null : (selectedMood ?? this.selectedMood),
      currentNavIndex: currentNavIndex ?? this.currentNavIndex,
    );
  }

  @override
  List<Object?> get props => [
    userName,
    moods,
    sessions,
    exercises,
    selectedMood,
    currentNavIndex,
  ];
}

/// One-shot navigation state. After navigation the BLoC restores HomeLoaded.
class HomeNavigateTo extends HomeState {
  final String route;
  final Object? arguments;

  const HomeNavigateTo({required this.route, this.arguments});

  @override
  List<Object?> get props => [route, arguments];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}