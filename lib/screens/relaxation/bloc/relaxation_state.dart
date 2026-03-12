
import 'package:equatable/equatable.dart';

abstract class RelaxationState extends Equatable {
  const RelaxationState();

  @override
  List<Object?> get props => [];
}

class RelaxationInitial extends RelaxationState {}

class RelaxationLoading extends RelaxationState {}

class RelaxationLoaded extends RelaxationState {}

class RelaxationError extends RelaxationState {
  final String message;
  const RelaxationError(this.message);

  @override
  List<Object?> get props => [message];
}