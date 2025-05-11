import 'package:fruiteshubdashboard2/core/enums/order_enum.dart';
import 'package:fruiteshubdashboard2/features/orders/data/models/OrderProductModel.dart';
import 'package:fruiteshubdashboard2/features/orders/data/models/ShippingAdressModel.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/entities/order_entity.dart';


class OrderModel {
  final double totalPrice;
  final String uId;
  final ShippingAddressModel shippingAddressModel;
  final List<OrderProductModel> orderProducts;
  final String paymentMethod;
  final String? status;
  final String orderID;

  OrderModel(
      {required this.totalPrice,
      required this.uId,
      required this.status,
      required this.orderID,
      required this.shippingAddressModel,
      required this.orderProducts,
      required this.paymentMethod});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['uId'] == null || json['paymentMethod'] == null) {
      throw FormatException('Missing required fields in order JSON');
    }

    return OrderModel(

      status: json['status'],
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      uId: json['uId'] ?? '',
      orderID:    json["orderId"]  ,
     // Uuid().v4(), json["orderId"]


      shippingAddressModel:
          ShippingAddressModel.fromJson(json['shippingAddressModel'] ?? {}),
      orderProducts: (json['orderProducts'] as List<dynamic>? ?? [])
          .map((e) => OrderProductModel.fromJson(e))
          .toList(),
      paymentMethod: json['paymentMethod'] ?? '',
    );
  }

  toJson() => {
         'orderId':orderID,
        'totalPrice': totalPrice,
        'uId': uId,
        'status': 'pending',
        'date': DateTime.now().toString(),
        'shippingAddressModel': shippingAddressModel.toJson(),
        'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
        'paymentMethod': paymentMethod,
      };

  toEntity() => OrderEntity(
        status: fetchEnum(),
        orderID: orderID,
        totalPrice: totalPrice,
        uId: uId,
        shippingAddressModel: shippingAddressModel.toEntity(),
        orderProducts: orderProducts.map((e) => e.toEntity()).toList(),
        paymentMethod: paymentMethod,
      );

  OrderStatusEnum fetchEnum() {
    return OrderStatusEnum.values.firstWhere((e) {
      var enumStatus = e.name.toString();
      return enumStatus == (status ?? 'pending');
    });
  }
}
