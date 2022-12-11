import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/user_entity.dart';

final usersDataBase = StateProvider<List<UserEntity>>(
  (ref) {
    return [
      UserEntity(
        birthdate: DateTime.now(),
        cpf: '413.002.780-80',
        email: 'email@gmail.com',
        guid: 'e96b4aca-96a5-4c34-a8bf-21baa246e015',
        name: 'Nome Sobrenome',
        nickName: 'Apelido',
        phone: '(35) 2222-1111',
      ),
    ];
  },
);
