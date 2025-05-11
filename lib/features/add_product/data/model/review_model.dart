import 'package:fruiteshubdashboard2/features/add_product/domain/entities/review_entity.dart';

class ReviewModel {
  final String name;

  final String rating;

  final String image;

  final String date;

  final String reviewDescription;

  ReviewModel(
      {required this.name,
        required this.rating,
        required this.image,
        required this.date,
        required this.reviewDescription});
  factory ReviewModel.fromEntity(ReviewEntity reviewEntity) {
    return ReviewModel(
      name: reviewEntity.name,
      image: reviewEntity.image,
      rating: reviewEntity.rating,
      date: reviewEntity.date,
      reviewDescription: reviewEntity.reviewDescription,
    );
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      name: json['name'],
      image: json['image'],
      rating: json['rating'],
      date: json['date'],
      reviewDescription: json['reviewDescription'],
    );
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'rating': rating, // Fixed spelling from 'ratting' to 'rating'
      'date': date,
      'reviewDescription': reviewDescription,
    };
  }

}
