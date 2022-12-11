class Validators {
  static bool cpfOrCnpj(String text) => text.validatorCNPJorCPF;
  static bool phone(String text) => _phoneRegex.hasMatch(text);
  static bool email(String email) => _emailRegex.hasMatch(email);
  static bool name(String name) => _nameRegex.hasMatch(name);

  static final RegExp _emailRegex =
      RegExp(r"^([\w\.\-]+)(@+)([\w\-]+)((\.(\w){2,3})+)$");
  static final RegExp _phoneRegex = RegExp(
      r"^(?:(?:\+|00)?(55)\s?)?(?:\(?([1-9][0-9])\)?\s?)?(?:((?:9\d|[2-9])\d{3})-?(\d{4}))$");

  static final _nameRegex = RegExp(
      r"([A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'\-\_]{2,}?(\s){1}?[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'\-\_]{2,}?)");
}

extension ValidatorsOnString on String {
  bool get validatorCNPJorCPF {
    if (this == '') {
      return false;
    }
    //Remove máscara e outros dados do String
    String dadoFiltrado = replaceAll(RegExp('[/.-]'), '');

    //Cnpj
    if (dadoFiltrado.length == 14) {
      List<String> cnpjsInvalidos = [
        '00000000000000',
        '11111111111111',
        '22222222222222',
        '33333333333333',
        '44444444444444',
        '55555555555555',
        '66666666666666',
        '77777777777777',
        '88888888888888',
        '99999999999999',
      ];
      //checa listanegra
      if (cnpjsInvalidos.contains(dadoFiltrado)) {
        return false;
      }
      //Calculo primeiro DV
      List<int> multiplicadoresDV1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
      String cnpj = dadoFiltrado.substring(0, 12);
      List<String> listaCNPJ = cnpj.split('');
      int soma1 = 0;
      for (int i = 0; i < 12; i++) {
        soma1 += int.parse(listaCNPJ[i]) * multiplicadoresDV1[i];
      }
      int resto1 = soma1 % 11;
      String dv1 = '0';
      if (resto1 >= 2) {
        dv1 = '${11 - resto1}';
      }
      if (dadoFiltrado[12] != dv1) {
        return false;
      }

      //Calculo segundo DV
      List<int> multiplicadoresDV2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
      String cnpjDV1 = dadoFiltrado.substring(0, 13);
      List<String> listaCNPJDV1 = cnpjDV1.split('');
      int soma2 = 0;
      for (int i = 0; i < 13; i++) {
        soma2 += int.parse(listaCNPJDV1[i]) * multiplicadoresDV2[i];
      }
      int resto2 = soma2 % 11;
      String dv2 = '0';
      if (resto2 >= 2) {
        dv2 = '${11 - resto2}';
      }
      if (dadoFiltrado[13] != dv2) {
        return false;
      }
      return true;

      //Calculo CPF valido
    } else if (dadoFiltrado.length == 11) {
      //Lista Negra CPFS
      List<String> cnpjsInvalidos = [
        '00000000000',
        '11111111111',
        '22222222222',
        '33333333333',
        '44444444444',
        '55555555555',
        '66666666666',
        '77777777777',
        '88888888888',
        '99999999999',
      ];
      //checa listanegra
      if (cnpjsInvalidos.contains(dadoFiltrado)) {
        return false;
      }

      //primeiro DV
      List<int> multiplicadoresDV1 = [10, 9, 8, 7, 6, 5, 4, 3, 2];
      String cpf = dadoFiltrado.substring(0, 9);
      List<String> listaCPF = cpf.split('');
      int soma1 = 0;
      for (int i = 0; i < 9; i++) {
        soma1 += int.parse(listaCPF[i]) * multiplicadoresDV1[i];
      }
      int resto1 = soma1 % 11;
      String dv1 = '0';
      if (resto1 >= 2) {
        dv1 = '${11 - resto1}';
      }
      if (dadoFiltrado[9] != dv1) {
        return false;
      }

      //Calculo segundo DV
      List<int> multiplicadoresDV2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];
      String cpfDV1 = dadoFiltrado.substring(0, 10);
      List<String> listaCPFDV1 = cpfDV1.split('');
      int soma2 = 0;
      for (int i = 0; i < 10; i++) {
        soma2 += int.parse(listaCPFDV1[i]) * multiplicadoresDV2[i];
      }
      int resto2 = soma2 % 11;
      String dv2 = '0';
      if (resto2 >= 2) {
        dv2 = '${11 - resto2}';
      }
      if (dadoFiltrado[10] != dv2) {
        return false;
      }
      return true;
    } else {
      return false;
    }
  }
}
