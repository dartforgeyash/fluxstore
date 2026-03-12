
import 'package:equatable/equatable.dart';

abstract class MyActivitiesEvent extends Equatable {
  const MyActivitiesEvent();

  @override
  List<Object?> get props => [];
}

class MyActivitiesStarted extends MyActivitiesEvent {}