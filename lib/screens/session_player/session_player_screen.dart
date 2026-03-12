import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/bn_home/models/session_model.dart';
import 'package:fluxstore/screens/session_player/bloc/session_player_bloc.dart';
import 'package:fluxstore/screens/session_player/bloc/session_player_event.dart';
import 'package:fluxstore/screens/session_player/bloc/session_player_state.dart';

class SessionPlayerScreen extends StatefulWidget {
  const SessionPlayerScreen({super.key});

  static Widget builder(BuildContext context) {
    final session =
    ModalRoute.of(context)!.settings.arguments as SessionModel;

    return BlocProvider(
      create: (_) =>
      SessionPlayerBloc()..add(SessionPlayerStarted(session)),
      child: const SessionPlayerScreen(),
    );
  }

  @override
  State<SessionPlayerScreen> createState() => _SessionPlayerScreenState();
}

class _SessionPlayerScreenState extends State<SessionPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionPlayerBloc, SessionPlayerState>(
      listener: (context, state) {
        // Handle side-effects (navigation, snackbars) here.
      },
      builder: (context, state) {
        if (state is SessionPlayerLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is SessionPlayerError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        if (state is SessionPlayerLoaded) {
          // TODO: Implement SessionPlayerLoaded UI using state.session.
          return Scaffold(
            body: Center(child: Text(state.session.title)),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}