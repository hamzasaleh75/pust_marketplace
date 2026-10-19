part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class ChangeVisableEvent extends LoginEvent {}

class LoginUserEvent extends LoginEvent {}
