import 'package:dartz/dartz.dart';
import 'package:fruiteshubdashboard2/core/repos/product_repo.dart';
import 'package:fruiteshubdashboard2/core/services/DatabaseService.dart';
import 'package:fruiteshubdashboard2/core/utils/backend_endpoints.dart';
import 'package:fruiteshubdashboard2/errors/failure.dart';
import 'package:fruiteshubdashboard2/features/add_product/data/model/add_product_input_model.dart';
import 'package:fruiteshubdashboard2/features/add_product/domain/entities/add_product_input_entity.dart';

class ProductRepoImp implements ProductRepo {
  final DatabaseService databaseService;

  ProductRepoImp(this.databaseService);

  @override
  Future<Either<Failure, void>> addProduct(
      ProductEntity addProductInputEntity) async {
    try {
      await databaseService.addData(
          path: BackendEndPoints.productsCollection,
          data: ProductModel.fromEntity(addProductInputEntity).toJson());
      return Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to add product"));
    }
  }

  @override
  Future<Either<Failure, void>> addCategory(CategoryEntity addCategorynputEntity) async{
    try {
      await databaseService.addData(
          path: BackendEndPoints.categoriesCollection,
          data: CategoryModel.fromEntity(addCategorynputEntity).toJson());
      return Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to add product"));
    }
}}
