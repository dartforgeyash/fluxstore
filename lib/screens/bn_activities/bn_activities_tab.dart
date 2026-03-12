import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/bn_activities/bloc/bn_activities_bloc.dart';

class ActivitiesTab extends StatefulWidget {
  const ActivitiesTab({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivitiesBloc()..add(ActivitiesStarted()),
      child: const ActivitiesTab(),
    );
  }

  @override
  State<ActivitiesTab> createState() => _ActivitiesTabState();
}

class _ActivitiesTabState extends State<ActivitiesTab> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivitiesBloc, ActivitiesState>(
      listener: (context, state) {
        // Handle side-effects (navigation, snackbars) here.
      },
      builder: (context, state) {
        if (state is ActivitiesLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is ActivitiesError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        // TODO: Implement ActivitiesLoaded UI.
        return const Scaffold(
          body: Center(child: Text('Activities Tab')),
        );
      },
    );
  }
}