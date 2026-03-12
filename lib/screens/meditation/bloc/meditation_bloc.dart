import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/meditation/bloc/meditation_event.dart';
import 'package:fluxstore/screens/meditation/bloc/meditation_state.dart';

class MeditationBloc extends Bloc<MeditationEvent, MeditationState> {
  MeditationBloc() : super(MeditationInitial()) {
    on<MeditationStarted>(_onMeditationStarted);
  }

  Future<void> _onMeditationStarted(
    MeditationStarted event,
    Emitter<MeditationState> emit,
  ) async {
    emit(MeditationLoading());
    try {
      emit(MeditationLoaded());
    } catch (e) {
      emit(MeditationError(e.toString()));
    }
  }
}
