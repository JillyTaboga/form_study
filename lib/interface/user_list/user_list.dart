import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/remove_user_use_case.dart';
import 'user_list_controller.dart';

class UserListScreen extends HookConsumerWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final filter = ref.watch(filterUserListProvider);
    final users = ref.watch(userListFilteredProvider);
    final selectedForm = ref.watch(formProvider);

    //Necessário usar o TextEditingController devido a necessidade de alterar o
    //campo com clear em tempo de execução
    //Usar em conjunto com Hook é uma ótima opção pois todo o ciclo de vida do
    //controller é extraído e isolado
    final searchFieldController = useTextEditingController(text: filter);
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Usuários',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: forms.length,
                  itemBuilder: ((context, index) {
                    final form = forms[index];
                    final isSelected = selectedForm == form;
                    return FormButton(
                      isSelected: isSelected,
                      form: form,
                      onTap: () {
                        ref.read(formProvider.notifier).state = form;
                      },
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: searchFieldController,
                decoration: InputDecoration(
                  label: const Text('Filtro'),
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchFieldController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
                onChanged: (value) {
                  ref.read(filterUserListProvider.notifier).state = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: users.when(
                  data: (data) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final user = data[index];
                              return UserCard(
                                user: user,
                                onEdit: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return selectedForm.page(user);
                                      },
                                    ),
                                  );
                                  ref.invalidate(userListProvider);
                                },
                                onDelete: () async {
                                  ref
                                      .read(refreshingListProvider.notifier)
                                      .state = true;
                                  await ref.read(
                                    removeUserUseCase,
                                  )(user.guid!);
                                  ref.invalidate(userListProvider);
                                  ref
                                      .read(refreshingListProvider.notifier)
                                      .state = false;
                                },
                              );
                            },
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return selectedForm.page(null);
                                },
                              ),
                            );
                            ref.invalidate(userListProvider);
                          },
                          icon: const Icon(Icons.add),
                          label: const Text(
                            'Novo usuário',
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(
                      error.toString(),
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (ref.watch(refreshingListProvider))
                const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  const FormButton({
    Key? key,
    required this.isSelected,
    required this.form,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final UserForm form;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 200,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      duration: const Duration(
        milliseconds: 250,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isSelected ? Colors.lightBlueAccent.shade400 : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected ? kElevationToShadow[0] : kElevationToShadow[5],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Tooltip(
            message: form.description,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 5,
              ),
              child: Center(
                child: Text(
                  form.label,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.user,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  final UserEntity user;
  final void Function() onDelete;
  final void Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name),
        trailing: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.cpf),
            Text(user.email),
            Text(user.phone),
          ],
        ),
      ),
    );
  }
}
