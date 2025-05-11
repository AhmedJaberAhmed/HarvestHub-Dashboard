import 'package:dartz/dartz.dart';
import 'package:fruiteshubdashboard2/core/enums/order_enum.dart';
import 'package:fruiteshubdashboard2/errors/failure.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/entities/order_entity.dart';

abstract class OrdersRepo {
  Stream<Either<Failure, List<OrderEntity>>> fetchOrders();

  Future<Either<Failure, void>> updateOrder(
      {required OrderStatusEnum status, required String orderID});
}
