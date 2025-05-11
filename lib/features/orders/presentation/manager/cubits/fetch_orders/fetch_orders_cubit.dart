import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/entities/order_entity.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/repos/orders_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_orders_state.dart';

class FetchOrdersCubit extends Cubit<FetchOrdersState> {
  FetchOrdersCubit(this.ordersRepo) : super(FetchOrdersInitial());

  final OrdersRepo ordersRepo;

  StreamSubscription? _streamSubscription;

  void fetchOrders()   {
    emit(FetchOrdersLoading());
    _streamSubscription = ordersRepo.fetchOrders().listen((result) {
      result.fold((f) {
        emit(FetchOrdersFailure(f.message));
      }, (r) {
        emit(FetchOrdersSuccess(
          orders: r,
        ));
      });
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
