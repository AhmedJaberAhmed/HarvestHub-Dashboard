import 'dart:io';

import 'package:fruiteshubdashboard2/features/add_product/data/model/review_model.dart';
import 'package:fruiteshubdashboard2/features/add_product/domain/entities/add_product_input_entity.dart';

class ProductModel {
  final String name;
  final String code;
  final String description;
  final num price;
  final int sellingCount;
  final File image;
  final bool isFeatured;
  String? imageUrl;
  final int expirationsMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final num avgRating;
  final num ratingCount;
  final int unitAmount;
  final List<ReviewModel> reviews;


  ProductModel({
    required this.expirationsMonths,
    required this.reviews,
    required this.numberOfCalories,
    required this.unitAmount,
    required this.name,
    required this.code,
    required this.description,
    required this.price,
     required this.image,
    required this.isFeatured,
    this.sellingCount=0,
    this.imageUrl,
    required this.isOrganic ,
    this.avgRating = 0,
    this.ratingCount = 0,
  });

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
       reviews: entity.reviews.map((e) => ReviewModel.fromEntity( e)).toList(),
      name: entity.name,
      isOrganic:entity.isOrganic,
      code: entity.code,
      description: entity.description,
      price: entity.price,
      image: entity.image,
      isFeatured: entity.isFeatured,
      imageUrl: entity.imageUrl,
      expirationsMonths: entity.expirationsMonths,
      numberOfCalories: entity.numberOfCalories,
      unitAmount: entity.unitAmount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      "sellingCount":sellingCount,
      'code': code,
      'description': description,
      'price': price,
      'isFeatured': isFeatured,
      'imageUrl': imageUrl,
      'expirationsMonths': expirationsMonths,
      'numberOfCalories': numberOfCalories,
      'unitAmount': unitAmount,
      'isOrganic': isOrganic,
      'avgRating': avgRating,
      'ratingCount': ratingCount,
      'reviews':reviews.map((e)=>e.toJson()).toList()
    };
  }
}
