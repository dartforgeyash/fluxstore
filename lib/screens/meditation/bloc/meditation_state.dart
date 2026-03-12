
import 'package:equatable/equatable.dart';

abstract class MeditationState extends Equatable {
  const MeditationState();

  @override
  List<Object?> get props => [];
}

class MeditationInitial extends MeditationState {}

class MeditationLoading extends MeditationState {}

class MeditationLoaded extends MeditationState {}

class MeditationError extends MeditationState {
  final String message;
  const MeditationError(this.message);

  @override
  List<Object?> get props => [message];
}