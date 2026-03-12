
import 'package:equatable/equatable.dart';

abstract class MeditationEvent extends Equatable {
  const MeditationEvent();

  @override
  List<Object?> get props => [];
}

class MeditationStarted extends MeditationEvent {}