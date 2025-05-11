import 'package:bloc/bloc.dart';
import 'package:fruiteshubdashboard2/core/enums/order_enum.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/repos/orders_repo.dart';
import 'package:meta/meta.dart';

part 'update_order_state.dart';
class UpdateOrderCubit extends Cubit<UpdateOrderState> {
  UpdateOrderCubit(this.ordersRepo) : super(UpdateOrderInitial());

  final OrdersRepo ordersRepo;

  Future<void> updateOrder({required OrderStatusEnum status, required String orderID,}) async
  {
    emit(UpdateOrderLoading());

    final result = await ordersRepo.updateOrder(
      status: status,
      orderID: orderID,
    );

    result.fold((f) {
      emit(UpdateOrderFailure(f.message));
    }, (r) {
      emit(UpdateOrderSuccess());
    });
  }
}
