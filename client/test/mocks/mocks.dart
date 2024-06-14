import 'package:mockito/annotations.dart';
import 'package:tile_tally/features/auth/data/source/network/api_service.dart';
import 'package:tile_tally/features/auth/data/source/network/auth_service.dart';
import 'package:tile_tally/features/auth/data/source/network/user_repository.dart';

@GenerateMocks([ApiService, AuthService, UserRepository])
void main() {}
