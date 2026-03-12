import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/yoga/bloc/yoga_event.dart';
import 'package:fluxstore/screens/yoga/bloc/yoga_state.dart';

class YogaBloc extends Bloc<YogaEvent, YogaState> {
  YogaBloc() : super(YogaInitial()) {
    on<YogaStarted>(_onYogaStarted);
  }

  Future<void> _onYogaStarted(
    YogaStarted event,
    Emitter<YogaState> emit,
  ) async {
    emit(YogaLoading());
    try {
      emit(YogaLoaded());
    } catch (e) {
      emit(YogaError(e.toString()));
    }
  }
}
