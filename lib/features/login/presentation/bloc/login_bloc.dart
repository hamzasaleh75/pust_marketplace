import 'dart:developer';

import 'package:bloc/bloc.dart';
// import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';
// import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<ChangeVisableEvent>(_changeVisableEvent);
    on<LoginUserEvent>(_loginUserEvent);
  }

  bool isVisable = false;
  final GlobalKey<FormState> fornkey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> _changeVisableEvent(
    ChangeVisableEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(IsVisableLodingState());
    try {
      isVisable = !isVisable;

      emit(IsVisableLodedState());
    } catch (e) {
      emit(IsVisableErrorState(message: e.toString()));
    }
  }

  Future<void> _loginUserEvent(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginUserLoadingState());
    try {
      log(usernameController.text);
      log(passwordController.text);
      await Future.delayed(const Duration(seconds: 2));
      // emit(LoginUserErrorState(message: 'Error'));

      emit(LoginUserLoadedState());
    } catch (e) {
      emit(LoginUserErrorState(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
