import 'package:bloc/bloc.dart';
import 'package:fruiteshubdashboard2/core/repos/images_repo.dart';
import 'package:fruiteshubdashboard2/core/repos/product_repo.dart';
import 'package:fruiteshubdashboard2/features/add_product/domain/entities/add_product_input_entity.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.imagesRepo, this.productsRepo)
      : super(AddProductInitial());
  final ImagesRepo imagesRepo;
  final ProductRepo productsRepo;
  Future<void> addProduct(ProductEntity addProductInputEntity) async {
    emit(AddProductLoading());

    var result = await imagesRepo.uploadImage(addProductInputEntity.image);

    result.fold(
          (failure) { // Changed 'f' to 'failure' for clarity
        emit(AddProductFailure(failure.message)); // Ensure 'Failure' has 'message'
      },
          (url) async {
        addProductInputEntity.imageUrl = url;
        var productResult = await productsRepo.addProduct(addProductInputEntity);

        productResult.fold(
              (failure) { // Use consistent property name
            emit(AddProductFailure( ""));
          },
              (r) {
            emit(AddProductSuccess());
          },
        );
      },
    );
  }

}
