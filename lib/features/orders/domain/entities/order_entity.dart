
import 'package:fruiteshubdashboard2/core/enums/order_enum.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/entities/OrderProductEntity.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/entities/ShippingAdressEntityl.dart';

class OrderEntity {
  final double totalPrice;
  final String uId;
  final String orderID;
  final ShippingAddressEntity shippingAddressModel;
  final List<OrderProductEntity> orderProducts;
  final String paymentMethod;
  final OrderStatusEnum status;
  OrderEntity(
      {required this.totalPrice,
        required this.uId,
        required this.orderID,
        required this.status,
        required this.shippingAddressModel,
        required this.orderProducts,
        required this.paymentMethod});
}

// payment method