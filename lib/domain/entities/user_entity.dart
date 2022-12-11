import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    String? guid,
    @Default('') String name,
    @Default('') String cpf,
    @Default('') String email,
    @Default('') String phone,
    String? nickName,
    DateTime? birthdate,
  }) = _UserEntity;
}
