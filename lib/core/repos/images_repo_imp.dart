import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruiteshubdashboard2/core/repos/images_repo.dart';
import 'package:fruiteshubdashboard2/core/services/storage_service.dart';
import 'package:fruiteshubdashboard2/core/utils/backend_endpoints.dart';
import 'package:fruiteshubdashboard2/errors/failure.dart';

class ImagesRepoImp implements ImagesRepo {
  final StorageService storageService;

  ImagesRepoImp(this.storageService);

  @override
  Future<Either<Failure, String>> uploadImage(File image) async{
    try {
      String url = await storageService.uploadFile(
          image, BackendEndPoints.images);
      return Right(url);
    } catch(e){
      return Left(ServerFailure("Failed to upload image"));
    }
  }
}