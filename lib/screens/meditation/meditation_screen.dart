import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/meditation/bloc/meditation_bloc.dart';
import 'package:fluxstore/screens/meditation/bloc/meditation_event.dart';
import 'package:fluxstore/screens/meditation/bloc/meditation_state.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => MeditationBloc()..add(MeditationStarted()),
      child: const MeditationScreen(),
    );
  }

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeditationBloc, MeditationState>(
      listener: (context, state) {
        // Handle side-effects (navigation, snackbars) here.
      },
      builder: (context, state) {
        if (state is MeditationLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is MeditationError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        // TODO: Implement MeditationLoaded UI.
        return const Scaffold(
          body: Center(child: Text('Meditation Screen')),
        );
      },
    );
  }
}