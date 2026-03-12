import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/yoga/bloc/yoga_bloc.dart';
import 'package:fluxstore/screens/yoga/bloc/yoga_event.dart';
import 'package:fluxstore/screens/yoga/bloc/yoga_state.dart';

class YogaScreen extends StatefulWidget {
  const YogaScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => YogaBloc()..add(YogaStarted()),
      child: const YogaScreen(),
    );
  }

  @override
  State<YogaScreen> createState() => _YogaScreenState();
}

class _YogaScreenState extends State<YogaScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<YogaBloc, YogaState>(
      listener: (context, state) {
        // Handle side-effects (navigation, snackbars) here.
      },
      builder: (context, state) {
        if (state is YogaLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is YogaError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        // TODO: Implement YogaLoaded UI.
        return const Scaffold(
          body: Center(child: Text('Yoga Screen')),
        );
      },
    );
  }
}