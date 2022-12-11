import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/user_repository.dart';
import '../entities/user_entity.dart';

final getAllUsersUseCase = Provider<GetAllUsersUseCase>((ref) {
  final repository = ref.watch(userRepository);
  return GetAllUsersUseCase(repository);
});

class GetAllUsersUseCase {
  GetAllUsersUseCase(this._userRepository);
  final UserRepository _userRepository;

  Future<List<UserEntity>> call() async {
    return await _userRepository.getAllUsers();
  }
}
