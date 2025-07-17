import 'package:flutter/material.dart';
import 'package:fruiteshubdashboard2/features/add_product/presentation/view/add_product_view.dart';
import 'package:fruiteshubdashboard2/features/orders/presentation/views/orders_view.dart';
import '../../../core/widgets/custom_button.dart';
import '../../categories/presentation/widgets/Add category.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:30,),
            // Header
            Text(
              "Welcome to the Dashboard",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Manage your products and view orders efficiently.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 40),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "➕  Add Product",
                onPressed: () {
                  Navigator.pushNamed(context, AddProductView.routeName);
                },
              ),
            ), const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "➕  Add Category",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCategoryView()),
                  );

                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "📦  View Orders",
                onPressed: () {
                  // Later update this route to the actual orders screen
                  Navigator.pushNamed(context, OrdersView.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
