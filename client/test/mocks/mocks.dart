import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tile_tally/features/auth/data/sources/network/api_service.dart';
import 'package:tile_tally/features/auth/data/sources/network/auth_service.dart';
import 'package:tile_tally/features/shared/data/helpers/games_table_helper.dart';
import 'package:tile_tally/features/shared/data/helpers/players_table_helper.dart';
import 'package:tile_tally/features/shared/data/sources/local/local_storage_service.dart';

@GenerateMocks(
  [
    AuthApiService,
    AuthService,
    LocalStorageService,
    FlutterSecureStorage,
    GameTableHelper,
    PlayerTableHelper,
    Database,
    Transaction,
  ],
)
void main() {}
