import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/user_repository.dart';

final removeUserUseCase = Provider<RemoveUserUseCase>((ref) {
  final repository = ref.watch(userRepository);
  return RemoveUserUseCase(repository);
});

class RemoveUserUseCase {
  RemoveUserUseCase(this._repository);
  final UserRepository _repository;

  Future<void> call(String userGuid) async {
    await _repository.removeUser(userGuid);
  }
}
