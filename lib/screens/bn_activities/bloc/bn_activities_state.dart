part of 'bn_activities_bloc.dart';

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object?> get props => [];
}

class ActivitiesInitial extends ActivitiesState {}

class ActivitiesLoading extends ActivitiesState {}

class ActivitiesLoaded extends ActivitiesState {
  final String livePnLPrice;
  final String appVersion;

  const ActivitiesLoaded({
    this.livePnLPrice = '0.00',
    this.appVersion = '',
  });

  ActivitiesLoaded copyWith({
    String? livePnLPrice,
    String? appVersion,
  }) {
    return ActivitiesLoaded(
      livePnLPrice: livePnLPrice ?? this.livePnLPrice,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object?> get props => [livePnLPrice, appVersion];
}

class ActivitiesError extends ActivitiesState {
  final String message;
  const ActivitiesError(this.message);

  @override
  List<Object?> get props => [message];
}