import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/session_player/bloc/session_player_event.dart';
import 'package:fluxstore/screens/session_player/bloc/session_player_state.dart';

class SessionPlayerBloc
    extends Bloc<SessionPlayerEvent, SessionPlayerState> {
  SessionPlayerBloc() : super(SessionPlayerInitial()) {
    on<SessionPlayerStarted>(_onSessionPlayerStarted);
  }

  Future<void> _onSessionPlayerStarted(
      SessionPlayerStarted event,
      Emitter<SessionPlayerState> emit,
      ) async {
    emit(SessionPlayerLoading());
    try {
      emit(SessionPlayerLoaded(session: event.session));
    } catch (e) {
      emit(SessionPlayerError(e.toString()));
    }
  }
}