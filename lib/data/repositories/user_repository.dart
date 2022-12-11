import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/validators.dart';
import '../../domain/entities/user_entity.dart';
import '../data_sources/users_base.dart';

final userRepository = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref);
});

abstract class UserRepository {
  Future<void> addUser(UserEntity user);

  Future<List<UserEntity>> getAllUsers();

  Future<void> removeUser(String userGuid);

  Future<void> editUser(UserEntity user);
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this.ref);
  final Ref ref;

  @override
  Future<void> addUser(UserEntity user) async {
    await Future.delayed(const Duration(seconds: 1));
    final users = ref.read(usersDataBase);
    ref.read(usersDataBase.notifier).state = [...users, user];
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return await ref.read(usersDataBase);
  }

  @override
  Future<void> removeUser(String userGuid) async {
    await Future.delayed(const Duration(seconds: 1));
    List<UserEntity> oldState = ref.read(usersDataBase);
    oldState.removeWhere((element) => element.guid == userGuid);
    ref.read(usersDataBase.notifier).state = oldState;
  }

  @override
  Future<void> editUser(UserEntity user) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!Uuid.isValidUUID(fromString: user.guid ?? '')) {
      throw Exception('Guid inválido');
    }
    if (!Validators.cpfOrCnpj(user.cpf)) {
      throw Exception('CPF inválido');
    }
    if (!Validators.name(user.name)) {
      throw Exception('Nome inválido');
    }
    if (!Validators.email(user.email)) {
      throw Exception('Email inválido');
    }
    if (!Validators.phone(user.phone)) {
      throw Exception('Telefone inválido');
    }
    List<UserEntity> oldState = ref.read(usersDataBase);
    final userIndex =
        oldState.indexWhere((element) => element.guid == user.guid);
    oldState.removeAt(userIndex);
    oldState.insert(userIndex, user);
    ref.read(usersDataBase.notifier).state = oldState;
  }
}
