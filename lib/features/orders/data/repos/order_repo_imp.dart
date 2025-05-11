import 'package:dartz/dartz.dart';
import 'package:fruiteshubdashboard2/core/enums/order_enum.dart';
import 'package:fruiteshubdashboard2/core/services/DatabaseService.dart';
import 'package:fruiteshubdashboard2/core/utils/backend_endpoints.dart';
import 'package:fruiteshubdashboard2/errors/failure.dart';
import 'package:fruiteshubdashboard2/features/orders/data/models/order_model.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/entities/order_entity.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/repos/orders_repo.dart';


class OrdersRepoImpl implements OrdersRepo {
  final DatabaseService _dataService;

  OrdersRepoImpl(this._dataService);

  @override
  Stream<Either<Failure, List<OrderEntity>>> fetchOrders() async* {
    try {
      await for (var (data) in _dataService.streamData(path: BackendEndPoints.getOrders))
      {
        List<OrderEntity> orders = (data as List<dynamic>).map<OrderEntity>((e) => OrderModel.fromJson(e).toEntity()).toList();
        yield Right(orders);
      }
    } catch (e) {
      yield Left(ServerFailure('Failed to fetch orders'));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrder({required OrderStatusEnum status, required String orderID}) async {
    try {
      await _dataService.updateData(data: {
        'status': status.name,
      }, path: BackendEndPoints.updateOrder, documentId: orderID);
      return right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update order'));
    }
  }

}
