import 'package:equatable/equatable.dart';

abstract class MyActivitiesState extends Equatable {
  const MyActivitiesState();

  @override
  List<Object?> get props => [];
}

class MyActivitiesInitial extends MyActivitiesState {}

class MyActivitiesLoading extends MyActivitiesState {}

class MyActivitiesLoaded extends MyActivitiesState {}

class MyActivitiesError extends MyActivitiesState {
  final String message;
  const MyActivitiesError(this.message);

  @override
  List<Object?> get props => [message];
}