part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class AddProductCartEvent extends HomeEvent {
  final MockProduct product;
  final int quantity;
  AddProductCartEvent({required this.product, this.quantity = 1});
}

class UpdateProductCountEvent extends HomeEvent {
  final String productId;
  final int change;

  UpdateProductCountEvent({required this.productId, required this.change});
}

class ClearCartEvent extends HomeEvent {}
