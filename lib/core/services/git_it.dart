import 'package:fruiteshubdashboard2/core/repos/images_repo.dart';
import 'package:fruiteshubdashboard2/core/repos/images_repo_imp.dart';
import 'package:fruiteshubdashboard2/core/repos/product_repo.dart';
import 'package:fruiteshubdashboard2/core/repos/product_repo_imp.dart';
import 'package:fruiteshubdashboard2/core/services/DatabaseService.dart';
import 'package:fruiteshubdashboard2/core/services/SupabaseStorageService.dart';
import 'package:fruiteshubdashboard2/core/services/firestore_service.dart';
import 'package:fruiteshubdashboard2/core/services/storage_service.dart';
import 'package:fruiteshubdashboard2/features/orders/data/repos/order_repo_imp.dart';
import 'package:fruiteshubdashboard2/features/orders/domain/repos/orders_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<StorageService>(SupabaseStorageService());

  getIt.registerSingleton<DatabaseService>(FireStoreService());


  getIt.registerSingleton<ImagesRepo>(ImagesRepoImp(getIt.get<StorageService>()));

  getIt.registerSingleton<ProductRepo>(ProductRepoImp(getIt.get<DatabaseService>()));

  getIt.registerSingleton<OrdersRepo>(OrdersRepoImpl(getIt.get<DatabaseService>()));

}
