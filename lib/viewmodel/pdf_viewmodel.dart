// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import '../model/pdfModel.dart';
//
// class FilePickerViewModel extends ChangeNotifier {
//   PickedFileModel? _pickedFile;
//
//   PickedFileModel? get pickedFile => _pickedFile;
//
//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       File pickedFile = File(result.files.single.path!);
//       _pickedFile = PickedFileModel(pickedFile.path);
//       notifyListeners();
//     }
//   }
// }
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../constants/K_Network.dart';

class PdfViewModel extends ChangeNotifier {


  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

  final Map<int, Uint8List?> _signatureImagesMap = {};
  Map<int, Offset> _signaturePositionsMap = {};
  int currentPage = 0;

  GlobalKey<SfSignaturePadState> get signaturePadKey => _signaturePadKey;

  Map<int, Uint8List?> get signatureImagesMap => _signatureImagesMap;

  Map<int, Offset> get signaturePositionsMap => _signaturePositionsMap;

  set signaturePositionsMap(Map<int, Offset> value) {
    _signaturePositionsMap = value;
  }

  void updateSignaturePosition(Offset offset) {
    _signaturePositionsMap[currentPage] = offset;
    notifyListeners();
  }

  void handleClearButtonPressed() {
    _signaturePadKey.currentState!.clear();
    notifyListeners();
  }

  void saveSignature() async {
    RenderSignaturePad boundary = _signaturePadKey.currentContext!
        .findRenderObject() as RenderSignaturePad;
    ui.Image image = await boundary.toImage(
        // pixelRatio: 3.0
        );
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List signatureImageBytes = byteData!.buffer.asUint8List();
    _signatureImagesMap[currentPage] = signatureImageBytes;
    notifyListeners();
  }

  void generatePDF(BuildContext context) async {
    const existingPdfPath = KNetwork.pdfAsset;
    final existingPdfBytes =
        await DefaultAssetBundle.of(context).load(existingPdfPath);
    final existingPdf =
        PdfDocument(inputBytes: existingPdfBytes.buffer.asUint8List());

    _signatureImagesMap.forEach((pageIndex, signatureImageBytes) {
      if (signatureImageBytes != null) {
        final signatureImage = PdfBitmap(signatureImageBytes);
        final page = existingPdf.pages[pageIndex];
        Offset offset = _signaturePositionsMap[pageIndex] ?? Offset.zero;
        // Draw the signature image at the adjusted position
        page.graphics.drawImage(
            signatureImage,
            Rect.fromLTWH(
              offset.dx,
              offset.dy,
              offset.dx+page.getClientSize().width
                  -
                  (signatureImage.width +
                      MediaQuery.of(context).size.width * 0.25)
              ,
              offset.dy+ page.getClientSize().height -
                  (signatureImage.height +
                      MediaQuery.of(context).size.height * 0.9),
            ));
      }
    });
    // Save the changes to the existing PDF
    final modifiedPdfBytes = await existingPdf.save();
    // Write the modified PDF to a new file
    final directory = await getApplicationDocumentsDirectory();
    final outputPdfPath = '${directory.path}/output.pdf';
    File(outputPdfPath).writeAsBytesSync(modifiedPdfBytes);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: SfPdfViewer.file(
            File(outputPdfPath),
            interactionMode: PdfInteractionMode.selection,
            pageLayoutMode: PdfPageLayoutMode.single,
            scrollDirection: PdfScrollDirection.vertical,
          ),
        ),
      ),
    );
  }
}
// Rect.fromLTRB(left, top, left + width, top + height);
// Rect.fromLTRB(
//   offset.dx+ signatureImage.width.toDouble(),
//   offset.dy + signatureImage.height.toDouble()-130,
//   offset.dx+ signatureImage.width.toDouble(),
//   offset.dy+ signatureImage.height.toDouble()-130,
// ),
// Rect.fromCenter(
//   center: Offset(offset.dx, offset.dx),
//   width: offset.dx,
//   height: offset.dy - MediaQuery.of(context).size.height * 0.65,
// ),
// fromLTWH(
//   offset.dx,
//   offset.dy-MediaQuery.of(context).size.height*0.65,
//   offset.dx+signatureImage.width.toDouble()-MediaQuery.of(context).size.width*0.22,
//   offset.dy+signatureImage.height.toDouble()-MediaQuery.of(context).size.height*0.65,
// ),


// final PdfViewerController pdfViewerController = PdfViewerController();
// final SignatureController signatureController = SignatureController();
// final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
// final GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
// final Map<int, Uint8List> signaturesMap = {};
//
// /// Map to store signatures for each page
// final Map<int, Offset?> signaturePositionsMap = {};
//
// /// Map to store signature positions for each page
// final Map<int, String> editedTextMap = {};
//
// /// Map to store edited text for each page
// int currentPage = 0;
//
// void updateSignaturePosition(Offset offset) {
//   signaturePositionsMap[currentPage] = offset;
//   notifyListeners();
// }
//
// Future<void> saveSignature() async {
//   Uint8List? signatureBytes = await signatureController.toPngBytes();
//   notifyListeners();
//   signaturesMap[currentPage] = signatureBytes!;
//   signatureController.clear();
//   signaturePositionsMap[currentPage] = null;
//   notifyListeners();
// }