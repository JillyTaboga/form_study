import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../core/input_formatters.dart';
import '../../core/validators.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/add_user_use_case.dart';
import '../../domain/use_cases/edit_user_use_case.dart';

//Como primeira observação ao utilizar TextEditingControllers obrigatoriamente
//você precisará utilizar StatefulWidgets que são mais verbosos e necessitam de
//mais controles de ciclo de vida

class UserFormBase extends StatefulWidget {
  const UserFormBase({
    super.key,
    this.user,
  });

  final UserEntity? user;

  @override
  State<UserFormBase> createState() => _UserFormBaseState();
}

class _UserFormBaseState extends State<UserFormBase> {
  //6 varíaves desncessárias
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController cpfController;
  late TextEditingController nickNameController;
  late TextEditingController birthDayController;

  bool isNew = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String saveError = '';
  bool isSaving = false;

  @override
  void initState() {
    isNew = widget.user == null;
    setupControllers(user: widget.user);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant UserFormBase oldWidget) {
    if (widget.user != oldWidget.user) {
      //Lógica necessária para atualizar o estado caso o parâmetro do widget seja
      //alterado, no presente como o widget está sendo utilizado como uma screen
      //essa lógica dificilmente é útil, mas se o widget fosse utilizado dentro de
      //outro componente, especialmente uma lista, é um requisito essencial
      setState(() {
        nameController.text = widget.user?.name ?? '';
        emailController.text = widget.user?.email ?? '';
        phoneController.text = widget.user?.phone ?? '';
        cpfController.text = widget.user?.cpf ?? '';
        nickNameController.text = widget.user?.nickName ?? '';
        birthDayController.text = DateFormat('dd/MM/yyyy')
            .format(widget.user?.birthdate ?? DateTime.now());
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    //dispose de cada controlador
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cpfController.dispose();
    nickNameController.dispose();
    birthDayController.dispose();
    super.dispose();
  }

  //Função para inicializar os controllers desnecessária
  setupControllers({UserEntity? user}) {
    nameController = TextEditingController(text: user?.name);
    emailController = TextEditingController(text: user?.email);
    phoneController = TextEditingController(text: user?.phone);
    cpfController = TextEditingController(text: user?.cpf);
    nickNameController = TextEditingController(text: user?.nickName);

    //Lógica na view
    birthDayController = TextEditingController(
      text: user?.birthdate != null
          ? DateFormat('dd/MM/yyyy').format(user!.birthdate!)
          : null,
    );
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

  //Função desnecessária para extrair dados dos TextEditingController
  UserEntity createUserByControllers() {
    final birthDate = DateFormat('dd/MM/yyyy').parse(birthDayController.text);
    final newUser = UserEntity(
      guid: isNew ? const Uuid().v4() : widget.user!.guid!,
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      cpf: cpfController.text,
      nickName: nickNameController.text,
      birthdate: birthDate,
    );
    return newUser;
  }

  //Regra que seria isolada em um controller
  //No caso o ref foi utilizado somente para injetar a dependencia dos usecases
  saveUser(WidgetRef ref) async {
    final userToSave = createUserByControllers();
    setState(() {
      isSaving = true;
      saveError = '';
    });
    if (isNew) {
      try {
        await ref.read(addUserUseCase)(userToSave);
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
        await ref.read(editUserUseCase)(userToSave);
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
                          controller: nameController,
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
                          controller: nickNameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: inputDecoration('Apelido'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
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
                          controller: phoneController,
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
                          controller: cpfController,
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
                          controller: birthDayController,
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
