
import 'package:equatable/equatable.dart';

abstract class RelaxationEvent extends Equatable {
  const RelaxationEvent();

  @override
  List<Object?> get props => [];
}

class RelaxationStarted extends RelaxationEvent {}