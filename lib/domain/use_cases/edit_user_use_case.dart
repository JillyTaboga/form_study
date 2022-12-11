import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/user_repository.dart';
import '../entities/user_entity.dart';

final editUserUseCase = Provider<EditUserUseCase>((ref) {
  final repository = ref.watch(userRepository);
  return EditUserUseCase(repository);
});

class EditUserUseCase {
  EditUserUseCase(this._repository);
  final UserRepository _repository;

  Future<void> call(UserEntity user) async {
    await _repository.editUser(user);
  }
}
