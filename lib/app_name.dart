import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Название приложения',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
