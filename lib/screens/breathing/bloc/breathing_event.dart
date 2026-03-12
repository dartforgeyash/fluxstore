import 'package:equatable/equatable.dart';

abstract class BreathingEvent extends Equatable {
  const BreathingEvent();

  @override
  List<Object?> get props => [];
}

class BreathingStarted extends BreathingEvent {}