import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruiteshubdashboard2/core/repos/images_repo.dart';
import 'package:fruiteshubdashboard2/core/repos/product_repo.dart';
import 'package:fruiteshubdashboard2/core/services/git_it.dart';
import 'package:fruiteshubdashboard2/core/widgets/buildAppBar.dart';
import 'package:fruiteshubdashboard2/features/add_product/presentation/manager/add_product_cubit.dart';
import 'package:fruiteshubdashboard2/features/add_product/presentation/view/widgets/AddProductViewBodyBlocBuilder.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  static const routeName = "AddProductView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: buildAppBar("Add Product"),
      body: BlocProvider(
        create: (context) =>
            AddProductCubit(getIt.get<ImagesRepo>(), getIt.get<ProductRepo>() ),
        child: AddProductViewBodyBlocBuilder(),
      ),
    );
  }
}
