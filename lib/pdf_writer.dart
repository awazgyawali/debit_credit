import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PDFWriter {
  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await _localPath;
    return File('$path/test.pdf');
  }

  writeSomething(data) async {
    final pdf = PDFDocument(deflate: zlib.encode);
    final page = PDFPage(pdf, pageFormat: PDFPageFormat.a4);
    final g = page.getGraphics();
    final font = PDFFont(pdf);
    final top = page.pageFormat.height;

    g.setColor(PDFColor.fromInt(0xff626FB0));
    g.drawRect(0, top - 20 * PDFPageFormat.mm, page.pageFormat.width,
        30 * PDFPageFormat.mm);
    g.fillPath();

    g.setColor(PDFColor.fromInt(0xffffffff));
    g.drawString(font, 30, "Debit Credit", 10.0 * PDFPageFormat.mm,
        top - 10.0 * PDFPageFormat.mm);

    var file = await localFile;
    file.writeAsBytesSync(pdf.save());
  }
}
