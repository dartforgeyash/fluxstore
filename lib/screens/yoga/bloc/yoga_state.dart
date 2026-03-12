
import 'package:equatable/equatable.dart';

abstract class YogaState extends Equatable {
  const YogaState();

  @override
  List<Object?> get props => [];
}

class YogaInitial extends YogaState {}

class YogaLoading extends YogaState {}

class YogaLoaded extends YogaState {}

class YogaError extends YogaState {
  final String message;
  const YogaError(this.message);

  @override
  List<Object?> get props => [message];
}