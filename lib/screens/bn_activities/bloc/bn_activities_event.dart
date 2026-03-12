part of 'bn_activities_bloc.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();

  @override
  List<Object?> get props => [];
}

/// Fired once when the tab mounts to load initial activities data.
class ActivitiesStarted extends ActivitiesEvent {}

/// Fired after returning from another screen to re-fetch activities data.
class ActivitiesProfileRefresh extends ActivitiesEvent {}