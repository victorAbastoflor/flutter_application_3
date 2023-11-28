import 'package:flutter/material.dart';

class SlideTopRoute extends PageRouteBuilder {
  final Widget page;

  SlideTopRoute({required this.page}) // Marcar como requerido
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin:
                  const Offset(0, -1), // Deslizamiento desde la parte superior
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
