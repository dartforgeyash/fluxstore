import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/relaxation/bloc/relaxation_event.dart';
import 'package:fluxstore/screens/relaxation/bloc/relaxation_state.dart';

class RelaxationBloc extends Bloc<RelaxationEvent, RelaxationState> {
  RelaxationBloc() : super(RelaxationInitial()) {
    on<RelaxationStarted>(_onRelaxationStarted);
  }

  Future<void> _onRelaxationStarted(
    RelaxationStarted event,
    Emitter<RelaxationState> emit,
  ) async {
    emit(RelaxationLoading());
    try {
      emit(RelaxationLoaded());
    } catch (e) {
      emit(RelaxationError(e.toString()));
    }
  }
}
