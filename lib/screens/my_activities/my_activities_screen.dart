import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/my_activities/bloc/my_activities_bloc.dart';
import 'package:fluxstore/screens/my_activities/bloc/my_activities_event.dart';
import 'package:fluxstore/screens/my_activities/bloc/my_activities_state.dart';

class MyActivitiesScreen extends StatefulWidget {
  const MyActivitiesScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => MyActivitiesBloc()..add(MyActivitiesStarted()),
      child: const MyActivitiesScreen(),
    );
  }

  @override
  State<MyActivitiesScreen> createState() => _MyActivitiesScreenState();
}

class _MyActivitiesScreenState extends State<MyActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyActivitiesBloc, MyActivitiesState>(
      listener: (context, state) {
        // Handle side-effects (navigation, snackbars) here.
      },
      builder: (context, state) {
        if (state is MyActivitiesLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is MyActivitiesError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        // TODO: Implement MyActivitiesLoaded UI.
        return const Scaffold(
          body: Center(child: Text('My Activities Screen')),
        );
      },
    );
  }
}