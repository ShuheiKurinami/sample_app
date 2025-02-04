import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/user_viewmodel.dart';
import 'views/user/user_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserViewModel()..fetchUsers(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: UserView(),
    );
  }
}
