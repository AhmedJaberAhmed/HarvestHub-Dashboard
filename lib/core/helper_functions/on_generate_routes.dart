import 'package:flutter/material.dart';
import 'package:fruiteshubdashboard2/features/add_product/presentation/view/add_product_view.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/views/orders_view.dart';

import '../../features/views/dashboard_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {

    case AddProductView.routeName:
      return MaterialPageRoute(builder: (context) => const AddProductView());




    case OrdersView.routeName:
      return MaterialPageRoute(builder: (context) => const OrdersView());




    case DashboardView.routeName:
      return MaterialPageRoute(builder: (context) => const DashboardView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
