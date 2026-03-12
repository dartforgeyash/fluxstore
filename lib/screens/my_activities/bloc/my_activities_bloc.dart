import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/my_activities/bloc/my_activities_event.dart';
import 'package:fluxstore/screens/my_activities/bloc/my_activities_state.dart';

class MyActivitiesBloc
    extends Bloc<MyActivitiesEvent, MyActivitiesState> {
  MyActivitiesBloc() : super(MyActivitiesInitial()) {
    on<MyActivitiesStarted>(_onMyActivitiesStarted);
  }

  Future<void> _onMyActivitiesStarted(
      MyActivitiesStarted event,
      Emitter<MyActivitiesState> emit,
      ) async {
    emit(MyActivitiesLoading());
    try {
      emit(MyActivitiesLoaded());
    } catch (e) {
      emit(MyActivitiesError(e.toString()));
    }
  }
}