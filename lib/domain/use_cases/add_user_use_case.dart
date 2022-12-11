import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/user_repository.dart';
import '../entities/user_entity.dart';

final addUserUseCase = Provider<AddUserUseCase>((ref) {
  final repository = ref.watch(userRepository);
  return AddUserUseCase(repository);
});

class AddUserUseCase {
  AddUserUseCase(this._repository);
  final UserRepository _repository;

  Future<void> call(UserEntity user) async {
    await _repository.addUser(user);
  }
}
