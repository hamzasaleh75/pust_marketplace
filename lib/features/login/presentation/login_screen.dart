import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_store/features/login/presentation/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginUserLoadedState) {
            context.go('/');
          }
          if (state is LoginUserErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Form(
            key: bloc.fornkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SIGN IN',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    controller: bloc.usernameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text('User name'),
                      hint: Text('User name'),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: !context.read<LoginBloc>().isVisable,
                    controller: bloc.passwordController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text('Passwoed'),
                      hint: Text('Passwoed'),
                      suffixIcon: IconButton(
                        onPressed: () {
                          bloc.add(ChangeVisableEvent());
                          // setState(() {
                          //   visibility = !visibility;
                          // });
                        },
                        icon: Icon(
                          context.watch<LoginBloc>().isVisable
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  state is LoginUserLoadingState
                      ? CircularProgressIndicator()
                      : SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              if (bloc.fornkey.currentState!.validate()) {
                                bloc.add(LoginUserEvent());
                              }
                            },

                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.primary,
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20,
                                  ),
                                ),
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            child: Text('Login'),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
