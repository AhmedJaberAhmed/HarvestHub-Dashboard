import 'package:flutter/material.dart';
import 'package:fruiteshubdashboard2/features/views/widgets/dashboard_view_body.dart';

class DashboardView extends StatelessWidget {
   const DashboardView({super.key});
static const routeName="dashboard";
   @override
   Widget build(BuildContext context) {
     return Scaffold(backgroundColor: Colors.white,
       body: DashboardViewBody(),
     );
   }
 }
