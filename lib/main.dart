import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruiteshubdashboard2/core/services/SupabaseStorageService.dart';
import 'package:fruiteshubdashboard2/core/services/custom_bloc_observer.dart';
import 'package:fruiteshubdashboard2/core/services/git_it.dart';
 import 'package:fruiteshubdashboard2/features/views/dashboard_view.dart';

import 'core/helper_functions/on_generate_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseStorageService.initSupabase();
  await SupabaseStorageService.createBuckets("fruits_images");

  Bloc.observer = CustomBlocObserver();

  await Firebase.initializeApp();

  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(color: Colors.white,
      debugShowCheckedModeBanner: false,
      initialRoute: DashboardView.routeName,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
