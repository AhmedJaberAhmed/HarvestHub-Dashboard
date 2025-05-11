import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruiteshubdashboard2/core/services/git_it.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/repos/orders_repo.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/manager/cubits/fetch_orders/fetch_orders_cubit.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/manager/cubits/update_order_cubit/update_order_cubit.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/views/widgets/OrdersViewBodyBuilder.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/views/widgets/update_order_builder.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  static const routeName = "orders";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchOrdersCubit(getIt.get<OrdersRepo>()),
        ),
        BlocProvider(
          create: (context) => UpdateOrderCubit(getIt.get<OrdersRepo>()),
        ),
      ],
      child: Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.blueGrey,
          title: const Text("Orders"),
        ),
        body: UpdateOrderBuilder(
          child: OrdersViewBodyBuilder(),
        ),
      ),
    );
  }
}
