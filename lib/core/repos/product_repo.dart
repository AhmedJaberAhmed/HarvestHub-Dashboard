import 'package:dartz/dartz.dart';
import 'package:fruiteshubdashboard2/features/add_product/domain/entities/add_product_input_entity.dart';
import 'package:fruiteshubdashboard2/errors/failure.dart';

abstract class ProductRepo {
  Future<Either<Failure, void>> addProduct(ProductEntity addProductInputEntity);
}
