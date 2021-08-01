

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

PdfColor customPDFColor(Color color){
  return PdfColor(color.red, color.green, color.blue, color.alpha);
}