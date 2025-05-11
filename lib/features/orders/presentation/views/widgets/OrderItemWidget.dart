import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruiteshubdashboard2/core/enums/order_enum.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/entities/order_entity.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/manager/cubits/update_order_cubit/update_order_cubit.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderEntity orderEntity;

  const OrderItemWidget({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Price + Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '\$${orderEntity.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 18 : 20,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    orderEntity.status.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: orderEntity.status == OrderStatusEnum.pending
                      ? Colors.orange
                      : orderEntity.status == OrderStatusEnum.accepted
                          ? Colors.green
                          : orderEntity.status == OrderStatusEnum.delivered
                              ? Colors.blue
                              : Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              ],
            ),

            const Divider(height: 24),

            // User Info
            Wrap(
              spacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(Icons.person, size: 18, color: Colors.grey),
                Text(
                  'User ID: ${orderEntity.uId}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Shipping Address
            const Text(
              'Shipping Address',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              orderEntity.shippingAddressModel.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 10),

            // Payment Method
            Wrap(
              spacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(Icons.payment, size: 18, color: Colors.grey),
                Text(
                  'Payment: ${orderEntity.paymentMethod}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Products List
            const Text(
              'Products',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderEntity.orderProducts.length,
              itemBuilder: (context, index) {
                final product = orderEntity.orderProducts[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        width: isSmallScreen ? 40 : 50,
                        height: isSmallScreen ? 40 : 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      'Qty: ${product.quantity}  |  \$${product.price.toStringAsFixed(2)} each',
                      style: const TextStyle(fontSize: 13),
                    ),
                    trailing: Text(
                      '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Wrap(
              spacing: 12,
              runSpacing: 8,
              alignment: WrapAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // Confirm logic
                    context.read<UpdateOrderCubit>().updateOrder(
                        status: OrderStatusEnum.accepted,
                        orderID: orderEntity.orderID);
                  },
                  icon: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                  label: const Text('Accept Order'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // Cancel logic
                    context.read<UpdateOrderCubit>().updateOrder(
                        status: OrderStatusEnum.cancelled,
                        orderID: orderEntity.orderID);

                    print(orderEntity.orderID);
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.redAccent,
                  ),
                  label: const Text('Cancel Order'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    context.read<UpdateOrderCubit>().updateOrder(
                          status: OrderStatusEnum.delivered,
                          orderID: orderEntity.orderID,
                        );
                  },
                  icon: const Icon(
                    Icons.local_shipping_outlined, // delivery truck icon
                    color: Colors.blue,
                  ),
                  label: const Text('Mark as Delivered'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
