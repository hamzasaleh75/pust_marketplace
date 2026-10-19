part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class IsVisableLodingState extends LoginState {}

final class IsVisableLodedState extends LoginState {}

final class IsVisableErrorState extends LoginState {
  final String message;

  IsVisableErrorState({required this.message});
}

final class LoginUserLoadingState extends LoginState {}

final class LoginUserLoadedState extends LoginState {}

final class LoginUserErrorState extends LoginState {
  final String message;

  LoginUserErrorState({required this.message});
}
