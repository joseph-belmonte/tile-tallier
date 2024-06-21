import 'package:mockito/annotations.dart';
import 'package:tile_tally/features/auth/data/sources/network/api_service.dart';
import 'package:tile_tally/features/auth/data/sources/network/auth_service.dart';
import 'package:tile_tally/features/auth/domain/repositories/user_repository.dart';

@GenerateMocks([ApiService, AuthService, UserRepository])
void main() {}
