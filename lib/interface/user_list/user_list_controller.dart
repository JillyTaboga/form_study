import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/string_helpers.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/get_all_users_use_case.dart';
import '../user_form_advance/user_form_advanced.dart';
import '../user_form_base _no_controllers/user_form_base_no_controllers.dart';
import '../user_form_base/user_form_base.dart';

final formProvider = StateProvider<UserForm>((ref) {
  return forms.first;
});

final List<UserForm> forms = [
  UserForm(
    page: (user) => UserFormBase(user: user),
    label: 'Formulário base com TextEditingControllers',
    description:
        'Formulário base, sem controlador de estado, usando somente a base do Flutter e com TextEditingControllers para receber os valores dos fields',
  ),
  UserForm(
    page: (user) => UserFormBaseNoControllers(user: user),
    label: 'Formulário base sem TextEditingControllers',
    description:
        'Formulário base, sem controlador de estado, usando somente a base do Flutter e sem TextEditingControllers, utilizando o próprio model para armazenar os dados dos fields',
  ),
  UserForm(
    page: (user) => UserFormAdvanced(startUser: user),
    label: 'Formulário avançado',
    description:
        'Formulário avançando utilizado StateNotifier do Riverpod para controle do estado',
  ),
];

final refreshingListProvider = StateProvider<bool>((ref) {
  return false;
});

final userListProvider = FutureProvider<List<UserEntity>>((ref) async {
  final users = await ref.watch(getAllUsersUseCase)();
  return users;
});

final userListFilteredProvider = FutureProvider<List<UserEntity>>((ref) async {
  final userProvider = await ref.watch(userListProvider.future);
  final filter = ref.watch(filterUserListProvider);
  final filteredList = userProvider
      .where(
        (element) =>
            (element.name + element.email + element.phone + element.phone)
                .toLowerCase()
                .removeDiatrics()
                .contains(
                  filter.toLowerCase().removeDiatrics(),
                ),
      )
      .toList();
  return filteredList;
});

final filterUserListProvider = StateProvider<String>((ref) {
  return '';
});

class UserForm {
  final Widget Function(UserEntity? user) page;
  final String label;
  final String description;
  UserForm({
    required this.page,
    required this.label,
    required this.description,
  });

  @override
  String toString() =>
      'UserForm(page: $page, label: $label, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserForm &&
        other.page == page &&
        other.label == label &&
        other.description == description;
  }

  @override
  int get hashCode => page.hashCode ^ label.hashCode ^ description.hashCode;
}
