import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quotation/src/components/save_file.dart';
import 'package:quotation/src/modal/data_print.dart';
import 'package:quotation/src/utils/util.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

///Local import

/// Render pdf of invoice
class InvoicePdf {
  Future<bool> generatePDF(PrintResponseModal printResponseModal) async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    Color hColor = Colors.green[300] ?? Colors.green;
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(customPDFColor(hColor)));
    //Generate PDF grid.
    final PdfGrid grid = _getGrid(printResponseModal);
    //Draw the header section by creating text element
    final PdfLayoutResult result =
        _drawHeader(page, pageSize, grid, printResponseModal);
    //Draw grid
    _drawGrid(page, grid, result, printResponseModal);
    //Add invoice footer
    _drawFooter(page, pageSize);
    //Save and dispose the document.
    final List<int> bytes = document.save();
    document.dispose();
    //Launch file.
    await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.pdf');
    return true;
  }

  //Draws the invoice header
  PdfLayoutResult _drawHeader(PdfPage page, Size pageSize, PdfGrid grid,
      PrintResponseModal printResponseModal) {
    //Draw rectangle
    Color hColor = Colors.green[300] ?? Colors.green;
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(customPDFColor(hColor)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 40));
    //Draw string
    page.graphics.drawString(
        'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 18),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(10, 0, pageSize.width, 43),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    //Create data format and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        '\r\n\r\nDate: ' + format.format(DateTime.now());
    // final Size contentSize = contentFont.measureString(invoiceNumber);
    Header headerData = printResponseModal.header;
    final String address = 'Bill To: \r\n\r\n' + headerData.to.join("\r\n\r\n");
    final Size contentSize = contentFont.measureString(address);
    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 60,
            contentSize.width + 30, contentSize.height + 30));
    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 60, pageSize.width - (contentSize.width + 30),
            contentSize.height + 30))!;
  }

  //Draws the grid
  void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result,
      PrintResponseModal printResponseModal) {
    List<Map<String, dynamic>> footer = printResponseModal.footer;
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom, 0, 0))!;
    //Draw grand total.

    print(footer);
    footer.asMap().forEach((index, element) {
      page.graphics.drawString(element["label"] ?? '',
          PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.regular),
          bounds: Rect.fromLTWH(
              quantityCellBounds!.left,
              result.bounds.bottom + (index * 10) + 10,
              quantityCellBounds!.width,
              quantityCellBounds!.height));
      page.graphics.drawString(element["value"],
          PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.regular),
          bounds: Rect.fromLTWH(
              totalPriceCellBounds!.left,
              result.bounds.bottom + (index * 10) + 10,
              totalPriceCellBounds!.width,
              totalPriceCellBounds!.height));
    });
  }

  //Draw the invoice footer data.
  void _drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    // page.graphics.drawLine(linePen, Offset(0, pageSize.height - 20),
    //     Offset(pageSize.width, pageSize.height - 20));
    const String footerContent = 'zeroFee.com';
    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 20, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid _getGrid(PrintResponseModal printResponseModal) {
    List<Map<String, dynamic>> columns = printResponseModal.columns;
    List<Map<String, dynamic>> data = printResponseModal.data;
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    // grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Secify the columns count to the grid.
    grid.columns.add(count: columns.length);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    Color hColor = Colors.green[300] ?? Colors.green;
    headerRow.style.backgroundBrush = PdfSolidBrush(customPDFColor(hColor));
    headerRow.style.textBrush = PdfBrushes.black;
    PdfColor pdfColor = customPDFColor(hColor);
    PdfPen pdfPen = new PdfPen(pdfColor);
    columns.asMap().forEach((index, element) {
      headerRow.cells[index].value = element['label'];
      // headerRow.cells[index].style.backgroundBrush = PdfSolidBrush(pdfColor);
      headerRow.cells[index].style.borders =
          PdfBorders(left: pdfPen, right: pdfPen, top: pdfPen, bottom: pdfPen);
      print(element['label']);
      headerRow.cells[index].stringFormat.alignment = PdfTextAlignment.center;
    });
    // headerRow.cells[0].value = 'Product Id';
    // headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    int rowIndex = -1;
    for (var rowData in data) {
      rowIndex += 1;
      _addProducts(columns, rowData, rowIndex, grid);
    }
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void _addProducts(List<Map<String, dynamic>> columns,
      Map<String, dynamic> rowData, int rowIdx, PdfGrid grid) {
    print(rowIdx);
    final PdfGridRow row = grid.rows.add();
    Color hColor = (rowIdx % 2 == 0 ? Colors.green[200] : Colors.green[50]) ??
        Colors.green;
    row.style.textBrush = PdfBrushes.black;
    PdfColor pdfColor = customPDFColor(hColor);
    PdfPen pdfPen = new PdfPen(pdfColor);
    row.style.backgroundBrush = PdfSolidBrush(pdfColor);
    columns.asMap().forEach((index, element) {
      if (element['_key'] == 'sno') {
        print(element['_key']);
        row.cells[index].value = (rowIdx + 1).toString();
      } else {
        row.cells[index].value = rowData[element['_key']] ?? '---';
      }
      row.cells[index].style.borders =
          PdfBorders(left: pdfPen, right: pdfPen, top: pdfPen, bottom: pdfPen);
      row.cells[index].stringFormat.alignment = element['pdfTextAlignment'];
    });
  }

  //Get the total amount.
  double _getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
          grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }
}
