import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/breathing/bloc/breathing_event.dart';
import 'package:fluxstore/screens/breathing/bloc/breathing_state.dart';

class BreathingBloc extends Bloc<BreathingEvent, BreathingState> {
  BreathingBloc() : super(BreathingInitial()) {
    on<BreathingStarted>(_onBreathingStarted);
  }

  Future<void> _onBreathingStarted(
      BreathingStarted event,
      Emitter<BreathingState> emit,
      ) async {
    emit(BreathingLoading());
    try {
      emit(BreathingLoaded());
    } catch (e) {
      emit(BreathingError(e.toString()));
    }
  }
}