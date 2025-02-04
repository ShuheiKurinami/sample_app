import 'package:flutter/material.dart';
import 'views/user/user_view.dart';

class AppRoutes {
  static const String userView = '/userView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case userView:
        return MaterialPageRoute(builder: (_) => const UserView());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
