class ReviewEntity {
  final String name;

  final String rating;

  final String image;

  final String date;

  final String reviewDescription;

  ReviewEntity(
      {required this.name,
      required this.rating,
      required this.image,
      required this.date,
      required this.reviewDescription});
}
