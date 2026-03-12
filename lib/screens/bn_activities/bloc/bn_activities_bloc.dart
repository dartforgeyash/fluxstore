import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bn_activities_event.dart';
part 'bn_activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  ActivitiesBloc() : super(ActivitiesInitial()) {
    on<ActivitiesStarted>(_onActivitiesStarted);
    on<ActivitiesProfileRefresh>(_onActivitiesProfileRefresh);
  }

  Future<void> _onActivitiesStarted(
      ActivitiesStarted event,
      Emitter<ActivitiesState> emit,
      ) async {
    emit(ActivitiesLoading());
    try {
      // TODO: Fetch initial activities data.
      emit(const ActivitiesLoaded());
    } catch (e) {
      emit(ActivitiesError(e.toString()));
    }
  }

  Future<void> _onActivitiesProfileRefresh(
      ActivitiesProfileRefresh event,
      Emitter<ActivitiesState> emit,
      ) async {
    final current = state;
    if (current is! ActivitiesLoaded) return;

    emit(ActivitiesLoading());
    try {
      // TODO: Re-fetch activities data.
      emit(current);
    } catch (e) {
      emit(ActivitiesError(e.toString()));
    }
  }
}