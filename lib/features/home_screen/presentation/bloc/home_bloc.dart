import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:quick_store/core/data/mock_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<AddProductCartEvent>(_addProductCartEvent,transformer: droppable());
    on<UpdateProductCountEvent>(_updateProductCountEvent,transformer: droppable());
    on<ClearCartEvent>(_clearCartEvent,transformer: restartable());
  }

  List<MockProduct> _products = List.from(MockData.products);

  List<MockProduct> get products => _products;

  set products(List<MockProduct> value) {
    _products = value;
  }

  final List<MockProduct> selectedProducts = [];

  Future<void> _addProductCartEvent(
    AddProductCartEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(AddProductCartLoadingState());

    try {
      final existingIndex = selectedProducts.indexWhere(
        (product) => product.id == event.product.id,
      );

      if (existingIndex != -1) {
        selectedProducts[existingIndex].count+=event.quantity;
      } else {
        selectedProducts.add(event.product.copyWith(count: event.quantity));
      }

      emit(AddProductCartLoadedState());
    } catch (e) {
      emit(AddProductCartErrorState(message: e.toString()));
    }
  }

  void _updateProductCountEvent(
    UpdateProductCountEvent event,
    Emitter<HomeState> emit,
  ) {
    final index = selectedProducts.indexWhere(
      (product) => product.id == event.productId,
    );

    if (index == -1) return;

    final newCount =
        selectedProducts[index].count + event.change;

    if (newCount <= 0) {
      selectedProducts.removeAt(index);
    } else {
      selectedProducts[index].count = newCount;
    }

    emit(AddProductCartLoadedState());
  }

  void _clearCartEvent(
    ClearCartEvent event,
    Emitter<HomeState> emit,
  ) {
    selectedProducts.clear();
    emit(AddProductCartLoadedState());
  }
}