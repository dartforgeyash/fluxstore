import 'package:equatable/equatable.dart';
import 'package:fluxstore/core/utils/enum.dart';

enum Default2FAMethod { phone, email }

class AccountState extends Equatable {
  final ApiStatus status;
  final String? errorMessage;
  final String? message;
  final String? livePnLPrice;
  final String appVersion;
  final Default2FAMethod selected2faMethod;
  final String selected2FAName;
  //final Data? profile;

  const AccountState({
    this.status = ApiStatus.initial,
    this.selected2faMethod = Default2FAMethod.phone,
    this.selected2FAName = 'Phone',
    this.errorMessage,
    this.livePnLPrice = "0.00",
    this.message,
    //this.profile,
    this.appVersion = '',
  });

  AccountState copyWith({
    ApiStatus? status,
    String? errorMessage,
    String? livePnLPrice,
    String? message,
    String? selected2FAName,
    Default2FAMethod? selected2faMethod,
    //Data? profile,
    String? appVersion,
  }) {
    return AccountState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      livePnLPrice: livePnLPrice ?? this.livePnLPrice,
      message: message ?? this.message,
      selected2faMethod: selected2faMethod ?? this.selected2faMethod,
      selected2FAName: selected2FAName ?? this.selected2FAName,
      //profile: profile ?? this.profile,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    livePnLPrice,
    message,
    selected2FAName,
    //profile,
    appVersion,
  ];
}
