
import 'package:equatable/equatable.dart';
import 'package:fluxstore/screens/bn_home/models/session_model.dart';

abstract class SessionPlayerEvent extends Equatable {
  const SessionPlayerEvent();

  @override
  List<Object?> get props => [];
}

/// Fired on mount. [session] is the route argument passed from HomeScreen.
class SessionPlayerStarted extends SessionPlayerEvent {
  final SessionModel session;
  const SessionPlayerStarted(this.session);

  @override
  List<Object?> get props => [session];
}