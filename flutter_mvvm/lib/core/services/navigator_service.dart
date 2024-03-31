import '../../core/base/base_service.dart';
import 'package:flutter/material.dart';

class NavigatorService extends BaseService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorService({required super.title});

  Future<Future<T?>?> navigateToPage<T>(MaterialPageRoute<T> pageRoute) async {
    log.i('navigateToPage: pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log.e('navigateToPage: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState?.push(pageRoute as Route<Future<T?>>);
  }

  Future<Future<T?>?> navigateToPageWithReplacement<T>(
      MaterialPageRoute<T> pageRoute) async {
    log.i('navigateToPageWithReplacement: '
        'pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log.e('navigateToPageWithReplacement: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState
        ?.pushReplacement(pageRoute as Route<Future<T?>>);
  }

  void pop<T>([T? result]) {
    log.i('goBack:');
    if (navigatorKey.currentState == null) {
      log.e('goBack: Navigator State is null');
      return;
    }
    navigatorKey.currentState?.pop(result);
  }
}
