import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../core/validators.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/add_user_use_case.dart';
import '../../domain/use_cases/edit_user_use_case.dart';

part 'user_form_controller.freezed.dart';

final userFormProvider = StateNotifierProvider.family
    .autoDispose<UserFormNotifier, UserFormState, UserEntity?>(
  (ref, user) {
    final addUser = ref.watch(addUserUseCase);
    final editUser = ref.watch(editUserUseCase);
    return UserFormNotifier(
      addUser,
      editUser,
      user: user,
    );
  },
);

class UserFormNotifier extends StateNotifier<UserFormState> {
  UserFormNotifier(
    this._addUserUseCase,
    this._editUserUseCase, {
    UserEntity? user,
  }) : super(
          UserFormState(
            user: user ??
                UserEntity(
                  guid: const Uuid().v4(),
                  birthdate: DateTime.now(),
                ),
            isNew: user == null,
          ).valid(),
        );

  final EditUserUseCase _editUserUseCase;
  final AddUserUseCase _addUserUseCase;

  //Separar cada setter permite ter cada regra de validação e negócio dentro
  //do controllador fornecendo grande vantagem sobre deixar na view a validaçao
  changeName(String text) {
    valid(state.copyWith.user(name: text));
  }

  changeEmail(String text) {
    valid(state.copyWith.user(email: text));
  }

  changePhone(String text) {
    valid(state.copyWith.user(phone: text));
  }

  changeNick(String text) {
    valid(state.copyWith.user(nickName: text));
  }

  changeCpf(String text) {
    valid(state.copyWith.user(cpf: text));
  }

  //Outro bom exemplo do setter estar no controller ser uma grande vantagem é
  //qualquer parse necessário fica de responsabilidade do controlador
  changeBirth(String? text) {
    try {
      final date = DateFormat('dd/MM/yyyy').parseLoose(text ?? '');
      valid(state.copyWith.user(birthdate: date));
    } catch (e) {
      valid(state.copyWith.user(birthdate: null));
    }
  }

  valid(UserFormState newState) {
    final validState = newState.valid();
    state = validState;
  }

  Future<bool> saveUser() async {
    state = state.copyWith(serverError: '');
    try {
      state = state.copyWith(isSaving: true);
      state.isNew
          ? await _addUserUseCase(state.user)
          : await _editUserUseCase(state.user);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false);
      state = state.copyWith(serverError: e.toString());
      return false;
    }
  }
}

@freezed
class UserFormState with _$UserFormState {
  const UserFormState._();
  const factory UserFormState({
    required UserEntity user,
    @Default(false) bool isSaving,
    @Default(UserFormErrors()) UserFormErrors errors,
    @Default('') String serverError,
    required bool isNew,
  }) = _UserFormState;

  UserFormState valid() {
    UserFormErrors newErrors = const UserFormErrors();
    if (!Validators.name(user.name)) {
      newErrors = newErrors.copyWith(
        name: 'Nome inválido, digite um nome e um sobrenome',
      );
    }
    if (!Validators.email(user.email)) {
      newErrors = newErrors.copyWith(
        email: 'Email inválido',
      );
    }
    if (!Validators.phone(user.phone)) {
      newErrors = newErrors.copyWith(
        phone: 'Telefone inválido',
      );
    }
    if (!Validators.cpfOrCnpj(user.cpf)) {
      newErrors = newErrors.copyWith(
        cpf: 'Cpf inválido',
      );
    }
    if (user.birthdate == null) {
      newErrors = newErrors.copyWith(
        birth: 'Data de nascimento inválida',
      );
    }
    return copyWith(errors: newErrors);
  }
}

@freezed
class UserFormErrors with _$UserFormErrors {
  const UserFormErrors._();
  const factory UserFormErrors({
    String? name,
    String? cpf,
    String? email,
    String? phone,
    String? nick,
    String? birth,
  }) = _UserFormErrors;

  bool get hasErrors =>
      name != null ||
      cpf != null ||
      email != null ||
      phone != null ||
      nick != null ||
      birth != null;
}
