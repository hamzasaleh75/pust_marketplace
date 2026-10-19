import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_store/core/bloc/bloc_observer.dart';
import 'package:quick_store/core/theme/theme_data.dart';
import 'package:quick_store/features/home_screen/presentation/bloc/home_bloc.dart';
import 'package:quick_store/features/home_screen/presentation/screens/navbar_screen.dart';
import 'package:quick_store/features/login/presentation/bloc/login_bloc.dart';
import 'package:quick_store/features/login/presentation/login_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
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
          builder: (BuildContext context, GoRouterState state) => BlocProvider(
            create: (context) => LoginBloc(),
            child: LoginScreen(),
          ),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: _router,
      ),
    );
  }
}
