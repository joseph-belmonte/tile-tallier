import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:tile_tally/features/auth/data/sources/local_storage/local_storage_service.dart';
import 'package:tile_tally/features/auth/data/sources/network/api_service.dart';
import 'package:tile_tally/features/auth/data/sources/network/auth_service.dart';

@GenerateMocks(
  [
    AuthApiService,
    AuthService,
    LocalStorageService,
    FlutterSecureStorage,
  ],
)
void main() {}
