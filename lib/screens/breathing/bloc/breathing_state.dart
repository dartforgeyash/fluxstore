import 'package:equatable/equatable.dart';

abstract class BreathingState extends Equatable {
  const BreathingState();

  @override
  List<Object?> get props => [];
}

class BreathingInitial extends BreathingState {}

class BreathingLoading extends BreathingState {}

class BreathingLoaded extends BreathingState {}

class BreathingError extends BreathingState {
  final String message;
  const BreathingError(this.message);

  @override
  List<Object?> get props => [message];
}