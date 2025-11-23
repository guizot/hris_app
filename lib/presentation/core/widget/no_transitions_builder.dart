import 'package:flutter/material.dart';

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();
  @override
  Widget buildTransitions<T>(Route<T> route, BuildContext context,
      Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child; // no animation
  }
}