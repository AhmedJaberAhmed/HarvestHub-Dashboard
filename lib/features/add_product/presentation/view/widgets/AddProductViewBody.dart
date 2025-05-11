import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruiteshubdashboard2/core/widgets/custom_button.dart';
import 'package:fruiteshubdashboard2/core/widgets/cutom_text_field.dart';
import 'package:fruiteshubdashboard2/core/widgets/isFeaturedCheckBox.dart';
import 'package:fruiteshubdashboard2/features/add_product/domain/entities/add_product_input_entity.dart';
import 'package:fruiteshubdashboard2/features/add_product/presentation/manager/add_product_cubit.dart';
import 'package:fruiteshubdashboard2/features/add_product/presentation/view/widgets/image_field.dart';
import 'package:fruiteshubdashboard2/features/add_product/presentation/view/widgets/isOrganic.dart';

class AddProductViewBody extends StatefulWidget {
  const AddProductViewBody({super.key});

  @override
  State<AddProductViewBody> createState() => _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? name, code, description;
  num? price, expirationMonths, numOfCalories, unitAmount;
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
                  hintText: "Product Name",
                  textInputType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) => price = num.tryParse(value ?? ""),
                hintText: "Product Price",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) => expirationMonths = num.tryParse(value ?? ""),
                hintText: "Expiration Months",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) => numOfCalories = num.tryParse(value ?? ""),
                hintText: "Number of Calories",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) => unitAmount = num.tryParse(value ?? ""),
                hintText: "Unit Amount",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) => code = value?.toLowerCase(),
                hintText: "Product Code",
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) => description = value,
                hintText: "Product Description",
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
                        description == null ||
                        price == null ||
                        expirationMonths == null ||
                        numOfCalories == null ||
                        unitAmount == null) {
                      showSnackBar("All fields are required.");
                      return;
                    }

                    final input = ProductEntity(
                      reviews: [],
                      isOrganic: isOrganic,
                      expirationsMonths: expirationMonths!.toInt(),
                      numberOfCalories: numOfCalories!.toInt(),
                      unitAmount: unitAmount!.toInt(),
                      image: image!,
                      name: name!,
                      code: code!,
                      price: price!,
                      description: description!,
                      isFeatured: isFeatured,
                    );

                    context.read<AddProductCubit>().addProduct(input);
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
