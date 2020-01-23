import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    WidgetBuilder builder,
    RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext ctx, Animation<double> animation,
      Animation<double> secondAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext ctx,
      Animation<double> animation,
      Animation<double> secondAnimation,
      Widget child) {
    if (route.settings.isInitialRoute) {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
