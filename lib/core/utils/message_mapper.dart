import 'package:fluxstore/core/extensions/l10n_extension.dart';
import 'package:flutter/material.dart';

extension MessageKeyTranslator on String {
  String translate(BuildContext context) {
    switch (this) {
      case 'SUCCESS_LOGIN':
        return context.l10n.loginSuccessMessage;
      case 'ERROR_INVALID_CREDENTIALS':
        return context.l10n.errorInvalidCredentials;
      // case 'TRUCK_NOT_FOUND':
      //   return context.l10n.truckNotFound;
      default:
        return isEmpty ? context.l10n.somethingWentWrong : this;
    }
  }
}
