import 'package:flutter/cupertino.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/entities/order_entity.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/views/widgets/OrderItemWidget.dart';

class OrderItemsListview extends StatelessWidget {
  const OrderItemsListview({super.key, required this.ordersModel});

  final List<OrderEntity> ordersModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ordersModel.length,
        itemBuilder: (context, index) {
          return OrderItemWidget(orderEntity: ordersModel[index]);
        });
  }
}
