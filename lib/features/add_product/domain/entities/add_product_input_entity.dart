import 'dart:io';

import 'package:fruiteshubdashboard2/features/add_product/domain/entities/review_entity.dart';

class ProductEntity {
  final String name;
  final String code;
  final String description;
  final num price;
  final File image;
  final bool isFeatured;
  String? imageUrl;
  final int expirationsMonths;
  final bool isOrganic  ;
  final int numberOfCalories;
  final int unitAmount;
  final num avgRating =0;
final num ratingCount =0;
final List<ReviewEntity> reviews;

  ProductEntity({
    required this.expirationsMonths,
    required this.reviews,
    required this.numberOfCalories,
    required this.unitAmount,
    required this.name,
      this.isOrganic=false,
    required this.code,
    required this.description,
    required this.price,
    required this.image,
    required this.isFeatured,
    this.imageUrl,
  });
}
