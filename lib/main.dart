import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_store/core/theme/theme_data.dart';
import 'package:quick_store/features/home_screen/screens/navbar_screen.dart';
import 'package:quick_store/features/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

GoRouter _router = GoRouter(
  // initialLocation: '/Login',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => NavbarScreen(),
      routes: [
        GoRoute(
          path: 'Login',
          builder: (BuildContext context, GoRouterState state) => LoginScreen(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: _router,
    );
  }
}
