import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';

class CustomNumberFormat {
  String value = '0';
  NumberFormat format = new NumberFormat();
}

CustomNumberFormat currency(context, number) {
  print(number);
  var validCharacters = RegExp(r'^[0-9]+$');
  Locale locale = Localizations.localeOf(context);
  NumberFormat format = NumberFormat.simpleCurrency(locale: locale.toString());
  final oCcy = new NumberFormat("#,##0.00", locale.toString());
  var val = '0';
  try {
    switch (number.runtimeType) {
      case String:
        val = number;
        val = number.contains(validCharacters)
            ? "${oCcy.format(int.parse(number))}"
            : "${oCcy.format(double.parse(number))}";
        break;
      case double:
        val = "${oCcy.format(number)}";
        break;
      default:
        val = "${oCcy.format(number)}";
        break;
    }
  } on Exception catch (_) {
    print(_);
    val = number;
  }
  print("val");
  print(val);
  CustomNumberFormat payload = new CustomNumberFormat();
  payload.format = format;
  payload.value = "${format.currencySymbol} $val";
  return payload;
}

PdfColor customPDFColor(Color color) {
  return PdfColor(color.red, color.green, color.blue, color.alpha);
}

removeWhereNull(_data) => _data
    .removeWhere((key, value) => key == null || value == null || value == '');

void removeNullAndEmptyParams(Map<String, Object> mapToEdit) {
// Remove all null values; they cause validation errors
  final keys = mapToEdit.keys.toList(growable: false);
  for (String key in keys) {
    final value = mapToEdit[key];
    if (value == null) {
      mapToEdit.remove(key);
    } else if (value is String) {
      if (value.isEmpty) {
        mapToEdit.remove(key);
      }
    } else if (value is Map) {
      removeNullAndEmptyParams(value as Map<String, Object>);
    }
  }
}

formatQuotationNumber(date) {
  final quotationFormat = new DateFormat('MM-d-H-m-s');
  return 'Q${quotationFormat.format(new DateTime.fromMillisecondsSinceEpoch(date)).replaceAll('-', '')}';
}

formatDate({date, format = 'yyyy-MM-dd'}) {
  final dateFormat = new DateFormat(format);
  return '${dateFormat.format(new DateTime.fromMillisecondsSinceEpoch(date))}';
}

getQueryParameters({key}) {
  var params = Modular.args?.queryParams;
  if (key != null) {
    return params![key];
  }
  return params;
}
