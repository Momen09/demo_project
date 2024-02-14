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
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class PdfViewModel extends ChangeNotifier {
  final PdfViewerController pdfViewerController = PdfViewerController();
  final SignatureController signatureController = SignatureController();
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  final GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
  final Map<int, Uint8List> signaturesMap = {};

  /// Map to store signatures for each page
  final Map<int, Offset?> signaturePositionsMap = {};

  /// Map to store signature positions for each page
  final Map<int, String> editedTextMap = {};

  /// Map to store edited text for each page
  int currentPage = 0;

  void updateSignaturePosition(Offset offset) {
    signaturePositionsMap[currentPage] = offset;
    notifyListeners();
  }

  Future<void> saveSignature() async {
    Uint8List? signatureBytes = await signatureController.toPngBytes();
    notifyListeners();
    signaturesMap[currentPage] = signatureBytes!;
    signatureController.clear();
    signaturePositionsMap[currentPage] = null;
    notifyListeners();
  }
}
