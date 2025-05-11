
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruiteshubdashboard2/core/helper_functions/getOrderDummyData.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/manager/cubits/fetch_orders/fetch_orders_cubit.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/views/widgets/OrdersViewBody.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrdersViewBodyBuilder extends StatefulWidget {
  const OrdersViewBodyBuilder({
    super.key,
  });

  @override
  State<OrdersViewBodyBuilder> createState() => _OrdersViewBodyBuilderState();
}


class _OrdersViewBodyBuilderState extends State<OrdersViewBodyBuilder> {
  @override
  void initState() {
    context.read<FetchOrdersCubit>().fetchOrders();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchOrdersCubit, FetchOrdersState>(
      builder: (context, state) {
        if (state is FetchOrdersSuccess) {
          return OrdersViewBody(orders: state.orders);
        } else if (state is FetchOrdersFailure) {
          return Center(child: Text(state.errMessege));
        }  else {
          return Skeletonizer(child: OrdersViewBody(orders: [
            getDummyOrder(),
            getDummyOrder(),
            getDummyOrder(),
          ])); // fallback
        }
      },
    );
  }
}