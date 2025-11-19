import 'package:flutter/material.dart';
import 'package:oss_frontend/core/navigation/route_observer.dart';

abstract class RouteAwareState<T extends StatefulWidget> extends State<T>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      appRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    super.dispose();
  }

  void onScreenFocusedFirstTime() {}
  void onScreenFocusedAgain() {}
}
