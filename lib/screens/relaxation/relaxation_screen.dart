import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/relaxation/bloc/relaxation_bloc.dart';
import 'package:fluxstore/screens/relaxation/bloc/relaxation_event.dart';
import 'package:fluxstore/screens/relaxation/bloc/relaxation_state.dart';

class RelaxationScreen extends StatefulWidget {
  const RelaxationScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => RelaxationBloc()..add(RelaxationStarted()),
      child: const RelaxationScreen(),
    );
  }

  @override
  State<RelaxationScreen> createState() => _RelaxationScreenState();
}

class _RelaxationScreenState extends State<RelaxationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelaxationBloc, RelaxationState>(
      listener: (context, state) {
        // Handle side-effects (navigation, snackbars) here.
      },
      builder: (context, state) {
        if (state is RelaxationLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is RelaxationError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        // TODO: Implement RelaxationLoaded UI.
        return const Scaffold(
          body: Center(child: Text('Relaxation Screen')),
        );
      },
    );
  }
}