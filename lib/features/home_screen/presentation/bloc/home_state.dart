part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class AddProductCartLoadingState extends HomeState {}

final class AddProductCartLoadedState extends HomeState {}

final class AddProductCartErrorState extends HomeState {
  final String message;
  AddProductCartErrorState({required this.message});
}
