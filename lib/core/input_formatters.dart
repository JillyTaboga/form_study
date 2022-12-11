import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    double value = double.parse(newValue.text.replaceAll(RegExp("[^0-9]"), ''));

    final formatter = NumberFormat.simpleCurrency();

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class DecimalInputFormatter extends TextInputFormatter {
  final double? maxValue;
  DecimalInputFormatter({
    this.maxValue,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String cleared = newValue.text.replaceAll(RegExp("[^0-9]"), '');

    double value = (double.tryParse(cleared) ?? 0);
    value = value / 100;

    if (maxValue != null && value > maxValue!) {
      value = maxValue!;
    }

    final String newText = NumberFormat('####,##0.00').format(value);
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText;
    String newReplaced = newValue.text.replaceAll(RegExp("[^0-9]"), '');
    if (newReplaced.isEmpty) {
      newText = '';
    } else if (newReplaced.length < 6) {
      newText = newReplaced;
    } else if (newReplaced.length < 9) {
      newText =
          '${newReplaced.substring(0, 5)}-${newReplaced.substring(5, newReplaced.length)}';
    } else {
      newText = '${newReplaced.substring(0, 5)}-${newReplaced.substring(5, 8)}';
    }
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = '';
    String newReplaced = '';
    if (newValue.text.contains('(') && !newValue.text.contains(')')) {
      newReplaced = newValue.text.substring(1, newValue.text.length - 1);
    } else {
      newReplaced = newValue.text;
    }
    newReplaced = newReplaced.replaceAll(RegExp("[^0-9]"), '');
    String ddd = '';
    String first = '';
    String last = '';

    if (newReplaced.isEmpty) {
      newText = '';
    }
    if (newReplaced.isNotEmpty) {
      int sub = newReplaced.length < 2 ? newReplaced.length : 2;
      ddd = '(${newReplaced.substring(0, sub)})';
      newText = ddd;
    }
    if (newReplaced.length > 2 && newReplaced.length < 11) {
      int sub = newReplaced.length < 7 ? newReplaced.length : 6;
      first = ' ${newReplaced.substring(2, sub)}';
      newText = ddd + first;
    }
    if (newReplaced.length > 6 && newReplaced.length < 11) {
      int sub = newReplaced.length < 11 ? newReplaced.length : 10;
      last = '-${newReplaced.substring(6, sub)}';
      newText = ddd + first + last;
    }
    if (newReplaced.length > 2 && newReplaced.length > 10) {
      int sub = newReplaced.length < 8 ? newReplaced.length : 7;
      first = ' ${newReplaced.substring(2, sub)}';
      newText = ddd + first;
    }
    if (newReplaced.length > 7 && newReplaced.length > 10) {
      int sub = newReplaced.length < 12 ? newReplaced.length : 11;
      last = '-${newReplaced.substring(7, sub)}';
      newText = ddd + first + last;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }
}

class CnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newReplaced = newValue.text.replaceAll(RegExp("[^0-9]"), '');
    String newText = '';

    String first2 = '';
    String second3 = '';
    String third3 = '';
    String mil4 = '';
    String dv2 = '';

    if (newReplaced.isEmpty) {
      newText = '';
    }
    if (newReplaced.isNotEmpty) {
      int sub = newReplaced.length < 2 ? newReplaced.length : 2;
      first2 = newReplaced.substring(0, sub);
      newText = first2;
    }
    if (newReplaced.length > 2) {
      int sub = newReplaced.length < 5 ? newReplaced.length : 5;
      second3 = '.${newReplaced.substring(2, sub)}';
      newText = first2 + second3;
    }
    if (newReplaced.length > 5) {
      int sub = newReplaced.length < 8 ? newReplaced.length : 8;
      third3 = '.${newReplaced.substring(5, sub)}';
      newText = first2 + second3 + third3;
    }
    if (newReplaced.length > 8) {
      int sub = newReplaced.length < 12 ? newReplaced.length : 12;
      mil4 = '/${newReplaced.substring(8, sub)}';
      newText = first2 + second3 + third3 + mil4;
    }
    if (newReplaced.length > 12) {
      int sub = newReplaced.length < 14 ? newReplaced.length : 14;
      dv2 = '-${newReplaced.substring(12, sub)}';
      newText = first2 + second3 + third3 + mil4 + dv2;
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

String? cpfFormatter(String? text) {
  if (text == null) return null;
  String newReplaced = text.replaceAll(RegExp("[^0-9]"), '');
  String newText = '';

  String first3 = '';
  String second3 = '';
  String third3 = '';
  String dv2 = '';

  if (newReplaced.isEmpty) {
    newText = '';
  }
  if (newReplaced.isNotEmpty) {
    int sub = newReplaced.length < 3 ? newReplaced.length : 3;
    first3 = newReplaced.substring(0, sub);
    newText = first3;
  }
  if (newReplaced.length > 3) {
    int sub = newReplaced.length < 6 ? newReplaced.length : 6;
    second3 = '.${newReplaced.substring(3, sub)}';
    newText = first3 + second3;
  }
  if (newReplaced.length > 6) {
    int sub = newReplaced.length < 9 ? newReplaced.length : 9;
    third3 = '.${newReplaced.substring(6, sub)}';
    newText = first3 + second3 + third3;
  }
  if (newReplaced.length > 9) {
    int sub = newReplaced.length < 11 ? newReplaced.length : 11;
    dv2 = '-${newReplaced.substring(9, sub)}';
    newText = first3 + second3 + third3 + dv2;
  }

  return newText;
}

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newReplaced = newValue.text.replaceAll(RegExp("[^0-9]"), '');
    String newText = '';

    String first3 = '';
    String second3 = '';
    String third3 = '';
    String dv2 = '';

    if (newReplaced.isEmpty) {
      newText = '';
    }
    if (newReplaced.isNotEmpty) {
      int sub = newReplaced.length < 3 ? newReplaced.length : 3;
      first3 = newReplaced.substring(0, sub);
      newText = first3;
    }
    if (newReplaced.length > 3) {
      int sub = newReplaced.length < 6 ? newReplaced.length : 6;
      second3 = '.${newReplaced.substring(3, sub)}';
      newText = first3 + second3;
    }
    if (newReplaced.length > 6) {
      int sub = newReplaced.length < 9 ? newReplaced.length : 9;
      third3 = '.${newReplaced.substring(6, sub)}';
      newText = first3 + second3 + third3;
    }
    if (newReplaced.length > 9) {
      int sub = newReplaced.length < 11 ? newReplaced.length : 11;
      dv2 = '-${newReplaced.substring(9, sub)}';
      newText = first3 + second3 + third3 + dv2;
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class IntlFormatter extends TextInputFormatter {
  IntlFormatter({required this.formatter});
  final NumberFormat formatter;
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    num value = 0;
    try {
      value = formatter.parse(newValue.text);
      final text = formatter.format(value);
      return newValue.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    } catch (e) {
      return newValue.copyWith(
          text: '', selection: const TextSelection.collapsed(offset: 0));
    }
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final dateValue = DateTime.tryParse(newValue.text);
    String date = '';
    var position = newValue.selection.baseOffset;
    if (dateValue == null) {
      final currentCaracteres = newValue.text.replaceAll(RegExp("[^0-9]"), '');
      for (int n = 0; n < currentCaracteres.length; n++) {
        final currentChar = currentCaracteres[n];
        if (n == 2 || n == 4) {
          date += '/';
        }
        if (n < 8) {
          date += currentChar;
        }
      }
    } else {
      date = DateFormat('dd/MM/yyyy').format(dateValue);
    }

    final spacePositions = [3, 6, 11, 14];

    if (spacePositions.contains(position)) {
      if (oldValue.text.length > newValue.text.length) {
        position--;
      } else {
        position++;
      }
    }
    if (position > date.length || position < 0) {
      position = date.length;
    }

    return newValue.copyWith(
      text: date,
      selection: TextSelection.collapsed(
        offset: position,
      ),
    );
  }
}
