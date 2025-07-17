import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruiteshubdashboard2/core/repos/images_repo.dart';
import 'package:fruiteshubdashboard2/core/repos/product_repo.dart';
import 'package:fruiteshubdashboard2/core/services/git_it.dart';
import 'package:fruiteshubdashboard2/core/widgets/buildAppBar.dart';
import 'package:fruiteshubdashboard2/features/add_product/domain/entities/add_product_input_entity.dart';
import 'package:fruiteshubdashboard2/features/add_product/presentation/manager/add_product_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/cutom_text_field.dart';
import '../../../../core/widgets/isFeaturedCheckBox.dart';
import '../../../add_product/presentation/view/widgets/image_field.dart';
import '../../../add_product/presentation/view/widgets/isOrganic.dart';

class AddCategoryView extends StatelessWidget {
  const AddCategoryView({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: buildAppBar("Add Category"),
      body: BlocProvider(
        create: (context) =>
            AddProductCubit(getIt.get<ImagesRepo>(), getIt.get<ProductRepo>() ),
        child: AddCategoryBodyBlocBuilder(),
      ),
    );
  }
}
















class AddCategoryBodyBlocBuilder extends StatelessWidget {
  const AddCategoryBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddProductSuccess) {
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: AwesomeSnackbarContent(
              title: 'Success!',
              message: 'Your operation was successful.',
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is AddProductFailure) {
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: AwesomeSnackbarContent(
              title: 'Error!',
              message: 'Your operation failed. Please try again.',
              contentType: ContentType.failure,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is AddProductLoading,

            child: AddCategoryViewBody());
      },
    );
  }
}
























class AddCategoryViewBody extends StatefulWidget {
  const AddCategoryViewBody({super.key});

  @override
  State<AddCategoryViewBody> createState() => _AddCategoryViewBodyState();
}

class _AddCategoryViewBodyState extends State<AddCategoryViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? name, code, description;

  File? image;
  bool isFeatured = false;
  bool isOrganic = false;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: CustomTextFormField(
                  onSaved: (value) => name = value,
                  hintText: "Category Name",
                  textInputType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 16),


              const SizedBox(height: 16),

              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) => code = value?.toLowerCase(),
                hintText: "Category Code",
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) => description = value,
                hintText: "Category Description",
                textInputType: TextInputType.text,
                maxLines: 100,
              ),
              const SizedBox(height: 16),
              IsFeaturedCheckBox(
                onChanged: (value) => setState(() => isFeatured = value),
              ),
              const SizedBox(height: 16),
              IsOrganicCheckBox(
                onChanged: (value) => setState(() => isOrganic = value),
              ),
              const SizedBox(height: 16),
              ImageField(
                onFileChanged: (file) => setState(() => image = file),
              ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: () {
                  if (image == null) {
                    showSnackBar("Please select an image.");
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (name == null ||
                        code == null ||
                        description == null ) {
                      showSnackBar("All fields are required.");
                      return;
                    }

                    final input = CategoryEntity(

                      reviews: [],
                      isOrganic: isOrganic,
                      expirationsMonths: 0,
                      numberOfCalories:0 ,
                      unitAmount: 0,
                      image: image!,
                      name: name!,
                      code: code!,
                      price: 0,
                      description: description!,
                      isFeatured: isFeatured,
                    );

                    context.read<AddProductCubit>().addCategory(input);
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                text: "ADD Product",
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}