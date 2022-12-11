import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/input_formatters.dart';
import '../../domain/entities/user_entity.dart';
import 'user_form_controller.dart';

//Como vamos trabalhar com um controlador de estado o widget pode/deve ser um stateless

class UserFormAdvanced extends HookConsumerWidget {
  const UserFormAdvanced({
    super.key,
    this.startUser,
  });

  final UserEntity? startUser;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(userFormProvider(startUser));
    final controller = ref.watch(userFormProvider(startUser).notifier);
    final mounted = useIsMounted();
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        state.isNew ? 'Novo usuário' : 'Edição de usuário',
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormUser(
                        initialValue: state.user.name,
                        onChanged: controller.changeName,
                        error: state.errors.name,
                        label: 'Nome',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormUser(
                        initialValue: state.user.nickName,
                        onChanged: controller.changeNick,
                        error: state.errors.nick,
                        label: 'Apelido',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormUser(
                        initialValue: state.user.email,
                        onChanged: controller.changeEmail,
                        error: state.errors.email,
                        inputType: TextInputType.emailAddress,
                        capitalization: TextCapitalization.none,
                        label: 'E-mail',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormUser(
                        initialValue: state.user.phone,
                        onChanged: controller.changePhone,
                        error: state.errors.phone,
                        label: 'Telefone',
                        inputType: TextInputType.phone,
                        formatter: PhoneInputFormatter(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormUser(
                        initialValue: state.user.cpf,
                        onChanged: controller.changeCpf,
                        formatter: CpfInputFormatter(),
                        inputType: TextInputType.number,
                        label: 'Cpf',
                        error: state.errors.cpf,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormUser(
                        initialValue: DateFormat('dd/MM/yyyy')
                            .format(state.user.birthdate ?? DateTime.now()),
                        onChanged: controller.changeBirth,
                        formatter: DateInputFormatter(),
                        inputType: TextInputType.number,
                        error: state.errors.birth,
                        label: 'Data de Nascimento',
                      ),
                    ],
                  ),
                ),
              ),
              Consumer(builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: (state.isSaving || state.errors.hasErrors)
                      ? null
                      : () async {
                          final result = await controller.saveUser();
                          // ignore: use_build_context_synchronously
                          if (result && mounted()) Navigator.pop(context);
                        },
                  child: state.isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Salvar'),
                );
              }),
              SizedBox(
                height: 20,
                child: Center(
                  child: state.serverError.isEmpty
                      ? null
                      : Text(
                          state.serverError,
                          style: const TextStyle(color: Colors.red),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//No modo avançado estou sugerindo utilizar um WidgetCustom para seu field,
//facilita a manutenção e diminui a carga uma vez que o método que retornava
//a decoração estava sendo processado em cada build, além de permitir melhores
//personalizações
class TextFormUser extends HookConsumerWidget {
  const TextFormUser({
    super.key,
    this.initialValue,
    this.error,
    this.label,
    this.onChanged,
    this.capitalization = TextCapitalization.words,
    this.inputType = TextInputType.name,
    this.formatter,
  });

  final void Function(String text)? onChanged;
  final String? label;
  final String? error;
  final String? initialValue;
  final TextInputType inputType;
  final TextCapitalization capitalization;
  final TextInputFormatter? formatter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasError = error?.isNotEmpty ?? false;
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            keyboardType: inputType,
            textCapitalization: capitalization,
            inputFormatters: formatter == null ? null : [formatter!],
            decoration: InputDecoration(
              label: label != null ? Text(label!) : null,
              labelStyle: TextStyle(
                color: hasError ? Colors.red : null,
              ),
              border: InputBorder.none,
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          if (hasError)
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
              child: Text(
                error!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
