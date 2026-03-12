abstract class AccountEvent {}

class AccountStarted extends AccountEvent {}

/// Fired after returning from the profile screen to re-fetch profile data.
class AccountProfileRefresh extends AccountEvent {}

class LoadAppVersionEvent extends AccountEvent {}
