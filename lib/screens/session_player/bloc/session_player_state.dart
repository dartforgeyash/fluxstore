
import 'package:equatable/equatable.dart';
import 'package:fluxstore/screens/bn_home/models/session_model.dart';

abstract class SessionPlayerState extends Equatable {
  const SessionPlayerState();

  @override
  List<Object?> get props => [];
}

class SessionPlayerInitial extends SessionPlayerState {}

class SessionPlayerLoading extends SessionPlayerState {}

class SessionPlayerLoaded extends SessionPlayerState {
  final SessionModel session;
  const SessionPlayerLoaded({required this.session});

  @override
  List<Object?> get props => [session];
}

class SessionPlayerError extends SessionPlayerState {
  final String message;
  const SessionPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}