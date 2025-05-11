import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/entities/order_entity.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/views/widgets/FilterSection.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/views/widgets/order_items_listview.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key, required this.orders});
  final List<OrderEntity>orders;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          const SizedBox(height: 24),
          const FilterSection(),
          SizedBox(
            height: 16,
          ),
          Expanded(
              child: OrderItemsListview(
            ordersModel:orders,
          ))
        ]));
  }
}
