import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _printRoute(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _printRoute(newRoute);
    }
  }

  void _printRoute(PageRoute route) {
    dev.log('🚀 CURRENT SCREEN: ${route.settings.name}');
  }
}
