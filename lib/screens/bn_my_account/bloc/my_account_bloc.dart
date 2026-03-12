import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/screens/bn_my_account/bloc/my_account_event.dart';
import 'package:fluxstore/screens/bn_my_account/bloc/my_account_state.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountState()) {
    on<AccountStarted>(_onAccountStarted);
    on<AccountProfileRefresh>(_onAccountProfileRefresh);
    on<LoadAppVersionEvent>(_loadAppVersion);
  }

  Future<void> _onAccountStarted(
    AccountStarted event,
    Emitter<AccountState> emit,
  ) async {
    // Fetch profile details on initial load.
    // await _fetchProfile(emit);
  }

  Future<void> _onAccountProfileRefresh(
    AccountProfileRefresh event,
    Emitter<AccountState> emit,
  ) async {
    // Call an api call to fetch the profile details
    //await _fetchProfile(emit);
  }

  Future<void> _loadAppVersion(
    LoadAppVersionEvent event,
    Emitter<AccountState> emit,
  ) async {
    final info = await PackageInfo.fromPlatform();
    emit(state.copyWith(appVersion: info.version));
  }
}
