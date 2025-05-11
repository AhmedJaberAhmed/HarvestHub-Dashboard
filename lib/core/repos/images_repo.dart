import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruiteshubdashboard2/errors/failure.dart';

abstract class ImagesRepo {
  Future<Either<Failure, String>> uploadImage(File image);
}
