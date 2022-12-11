import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../core/input_formatters.dart';
import '../../core/validators.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/add_user_use_case.dart';
import '../../domain/use_cases/edit_user_use_case.dart';

//Como ainda não trabalharemos com um controlador de estado ainda é necessário
//que o widget seja stateful

class UserFormBaseNoControllers extends StatefulWidget {
  const UserFormBaseNoControllers({
    super.key,
    this.user,
  });

  final UserEntity? user;

  @override
  State<UserFormBaseNoControllers> createState() =>
      _UserFormBaseNoControllersState();
}

class _UserFormBaseNoControllersState extends State<UserFormBaseNoControllers> {
  //6 varíaves viraram apenas uma
  late UserEntity user;

  bool isNew = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String saveError = '';
  bool isSaving = false;

  @override
  void initState() {
    isNew = widget.user == null;
    user = widget.user ??
        UserEntity(
          guid: const Uuid().v4(),
        );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UserFormBaseNoControllers oldWidget) {
    if (widget.user != oldWidget.user) {
      //Lógica necessária para atualizar o estado caso o parâmetro do widget seja
      //alterado, no presente como o widget está sendo utilizado como uma screen
      //essa lógica dificilmente é útil, mas se o widget fosse utilizado dentro de
      //outro componente, especialmente uma lista, é um requisito essencial
      setState(() {
        user = widget.user ?? UserEntity(guid: const Uuid().v4());
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  //Como o objetivo é analisar o TextFormField optei por não criar um TextFormField
  //custom mas utilizar o padrão do Flutter só com um método para garantir o
  //design adequado
  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      label: Text(label),
      border: InputBorder.none,
      fillColor: Colors.white,
      filled: true,
    );
  }

  //Regra que seria isolada em um controller
  //No caso o ref foi utilizado somente para injetar a dependencia dos usecases
  saveUser(WidgetRef ref) async {
    setState(() {
      isSaving = true;
      saveError = '';
    });
    if (isNew) {
      try {
        await ref.read(addUserUseCase)(user);
        if (mounted) Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          setState(() {
            isSaving = false;
            saveError = e.toString();
          });
        }
      }
    } else {
      try {
        await ref.read(editUserUseCase)(user);
        if (mounted) Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          setState(() {
            isSaving = false;
            saveError = e.toString();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Text(isNew ? 'Novo usuário' : 'Edição de usuário'),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue:
                              user.name, //Valor inicial vem do próprio objeto
                          onChanged: (value) {
                            user = user.copyWith(
                                name: value); //Callback repassa valor ao objeto
                          },
                          decoration: inputDecoration('Nome'),
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (!Validators.name(value ?? '')) {
                              return 'Nome inválido, digíte um nome e sobrenome';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: user.nickName,
                          onChanged: (value) {
                            user = user.copyWith(nickName: value);
                          },
                          textCapitalization: TextCapitalization.words,
                          decoration: inputDecoration('Apelido'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: user.email,
                          onChanged: (value) {
                            user = user.copyWith(email: value);
                          },
                          textCapitalization: TextCapitalization.none,
                          decoration: inputDecoration('E-mail'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!Validators.email(value ?? '')) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: user.phone,
                          onChanged: (value) {
                            user = user.copyWith(phone: value);
                          },
                          inputFormatters: [PhoneInputFormatter()],
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration('Telefone'),
                          validator: (value) {
                            if (!Validators.phone(value ?? '')) {
                              return 'Telefone inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: user.cpf,
                          onChanged: (value) {
                            user = user.copyWith(cpf: value);
                          },
                          inputFormatters: [CpfInputFormatter()],
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration('CPF'),
                          validator: (value) {
                            if (!Validators.cpfOrCnpj(value ?? '')) {
                              return 'Cpf inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: DateFormat('dd/MM/yyyy')
                              .format(user.birthdate ?? DateTime.now()),
                          onChanged: (value) {
                            try {
                              user = user.copyWith(
                                birthdate:
                                    DateFormat('dd/MM/yyyy').parseLoose(value),
                              );
                            } catch (e) {
                              user = user.copyWith(birthdate: null);
                            }
                          },
                          inputFormatters: [DateInputFormatter()],
                          decoration: inputDecoration('Data de Nascimento'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            try {
                              DateFormat('dd/MM/yyyy').parseLoose(value ?? '');
                            } catch (e) {
                              return 'Digite uma data de nasciento válida';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Consumer(builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: isSaving
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            saveUser(ref);
                          }
                        },
                  child: isSaving
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
                  child: saveError.isEmpty
                      ? null
                      : Text(
                          saveError,
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
