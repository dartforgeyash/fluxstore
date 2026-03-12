
import 'package:equatable/equatable.dart';

abstract class YogaEvent extends Equatable {
  const YogaEvent();

  @override
  List<Object?> get props => [];
}

class YogaStarted extends YogaEvent {}