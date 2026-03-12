import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/breathing/bloc/breathing_bloc.dart';
import 'package:fluxstore/screens/breathing/bloc/breathing_event.dart';
import 'package:fluxstore/screens/breathing/bloc/breathing_state.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => BreathingBloc()..add(BreathingStarted()),
      child: const BreathingScreen(),
    );
  }

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreathingBloc, BreathingState>(
      listener: (context, state) {
        // Handle side-effects (navigation, snackbars) here.
      },
      builder: (context, state) {
        if (state is BreathingLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is BreathingError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        // TODO: Implement BreathingLoaded UI.
        return const Scaffold(
          body: Center(child: Text('Breathing Screen')),
        );
      },
    );
  }
}