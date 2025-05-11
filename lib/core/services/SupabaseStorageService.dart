import 'dart:io';

import 'package:fruiteshubdashboard2/core/services/storage_service.dart';
import 'package:fruiteshubdashboard2/core/utils/backend_endpoints.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as b;

class SupabaseStorageService implements StorageService {
  static late Supabase _supabase;

  static createBuckets(String bucketName) async {
    var buckets = await _supabase.client.storage.listBuckets();

    bool isBucketExits = false;

    for (var buckte in buckets) {
      if (buckte.id == bucketName) {
        isBucketExits = true;
        break;
      }
    }

    if (!isBucketExits) {
      await _supabase.client.storage.createBucket(bucketName);
    }
  }

  static initSupabase() async {
    _supabase = await Supabase.initialize(
      url: BackendEndPoints.subpProjectKey,
      anonKey: BackendEndPoints.subaApiKey,
    );
  }

  @override
  Future<String> uploadFile(File file, String path) async {
    String fileName = b.basename(file.path);
    String extensionName = b.extension(file.path);

    var result = await _supabase.client.storage
        .from("fruits_images")
        .upload('$path/$fileName.$extensionName', file);

    final String publicUrl = _supabase.client.storage
        .from("fruits_images")
        .getPublicUrl("$path/$fileName.$extensionName");
     print(publicUrl);

    return publicUrl;
  }
}
