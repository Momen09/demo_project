// import 'dart:async';
// import 'dart:io' as io;
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:demo_project/constants/K_Network.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
//
// class Viewer extends StatefulWidget {
//   const Viewer({super.key});
//
//   static const routeName = 'Viewer';
//
//   @override
//   State<Viewer> createState() => _ViewerState();
// }
//
// class _ViewerState extends State<Viewer> {
//   final GlobalKey<SfSignaturePadState> _signaturePadGlobalKey = GlobalKey();
//   GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
//   Uint8List? _signatureImage;
//   late PdfViewerController _pdfViewerController;
//   final PageController _pageController = PageController();
//   int _currentPage = 1;
//   late PdfDocument _pdfDocument;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _loadPdfDocument();
//     _pdfViewerController = PdfViewerController();
//   }
//
//   // Load the PDF document
//   Future<void> _loadPdfDocument() async {
//     _pdfDocument = PdfDocument(
//       inputBytes: (await rootBundle.load('assets/pdf/flutter.pdf')).buffer.asUint8List(),
//     );
//   }
//
//   // Clear the signature in the SfSignaturePad.
//   void _handleClearButtonPressed() {
//     _signaturePadGlobalKey.currentState!.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer with Signature'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               // Show the Signature Pad when the edit button is pressed.
//               _showSignaturePad();
//             },
//           ),
//         ],
//       ),
//       body: PageView.builder(
//         controller: _pageController,
//         itemBuilder: (context, index) {
//           // Return a new instance of SfPdfViewer with a new key
//           return SfPdfViewer.asset(
//             'assets/pdf/flutter.pdf', // Load your PDF file
//             key: ValueKey<int>(index),
//             controller: _pdfViewerController,
//           );
//         },
//       ),
//     );
//   }
//
//   // Show the Signature Pad in a dialog.
//   void _showSignaturePad() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Signature Pad'),
//           content: Container(
//             height: 300,
//             child: SfSignaturePad(
//               key: _signaturePadGlobalKey,
//               strokeColor: Colors.black,
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 _handleClearButtonPressed();
//                 Navigator.of(context).pop();
//               },
//               child: Text('exit'),
//             ),
//             TextButton(
//               child: Text('Save'),
//               onPressed: () async {
//                 await _handleSaveButtonPressed();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _handleSaveButtonPressed() async {
//     // Get the signature image data
//     ui.Image image = await _signaturePadGlobalKey.currentState!.toImage();
//     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List imageData = byteData!.buffer.asUint8List();
//
//     // Save the signature image to a file
//     String filePath = await _saveImageToGallery(imageData);
//
//     // Update the signature image
//     setState(() {
//       _signatureImage = imageData;
//     });
//     _addImageAnnotationToPdf(filePath);
//     // Use the file path as needed
//     print('Image saved to: $filePath');
//   }
//
//   Future<String> _saveImageToGallery(Uint8List imageData) async {
//     try {
//       // Get the external storage directory
//       final directory = await getExternalStorageDirectory();
//       String filePath = '${directory!.path}/signature.png';
//
//       // Write the image data to the file
//       await File(filePath).writeAsBytes(imageData);
//
//       return filePath;
//     } catch (e) {
//       print('Error saving image: $e');
//       return '';
//     }
//   }
//
//   void _addImageAnnotationToPdf(String imagePath) async {
//     // Use the _pdfDocument object to add the image to the PDF
//     // This example assumes you want to add an image to the first page.
//     if (_pdfDocument.pages.count > 0) {
//       final PdfPage page = _pdfDocument.pages[0];
//       final Uint8List imageBytes = File(imagePath).readAsBytesSync();
//       final PdfBitmap image = PdfBitmap(imageBytes);
//       page.graphics.drawImage(image, Rect.fromLTWH(50, 50, 100, 50));
//     }
//
//     // Save the changes to the document
//     final List<int> bytes = await _pdfDocument.save();
//
//     // Load the updated PDF in the SfPdfViewer widget
//     // Create a new key for the SfPdfViewer widget to force it to rebuild
//     final GlobalKey<SfPdfViewerState> newKey = GlobalKey();
//
//     // Load the updated PDF in the new SfPdfViewer widget
//     setState(() {
//       _pdfDocument = PdfDocument(inputBytes: bytes);
//       _pdfViewerKey = newKey;
//     });
//     _currentPage++;
//     _pageController.jumpToPage(_currentPage);
//
//
//     print('Image added to PDF');
//   }
// }
// class SaveFile {
//   static Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
//     // Get external storage directory
//     io.Directory directory = await getApplicationSupportDirectory();
//
//     // Get directory path
//     String path = directory.path;
//
//     // Convert List<int> to Uint8List
//     Uint8List uint8List = Uint8List.fromList(bytes);
//
//     // Create an empty file to write PDF data
//     io.File file = io.File('$path/$fileName');
//
//     // Write PDF data using writeAsBytes
//     await file.writeAsBytes(uint8List, flush: true);
//
//     // Open the PDF document in mobile
//     OpenFile.open('$path/$fileName');
//   }
// }
// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
//
// class Viewer extends StatefulWidget {
//   const Viewer({super.key});
//
//   static const routeName = 'Viewer';
//
//   @override
//   State<Viewer> createState() => _ViewerState();
// }
//
// class _ViewerState extends State<Viewer> {
//   final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
//
//   @override
//   void initState() {
//     super.initState();
//     _requestPermission();
//   }
//
//   _requestPermission() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.storage,
//     ].request();
//     final info = statuses[Permission.storage].toString();
//     print(info);
//     _toastInfo(info);
//   }
//
//   void _handleClearButtonPressed() {
//     signatureGlobalKey.currentState!.clear();
//   }
//
//   void _handleSaveButtonPressed() async {
//     RenderSignaturePad boundary = signatureGlobalKey.currentContext!
//         .findRenderObject() as RenderSignaturePad;
//     ui.Image image = await boundary.toImage();
//     ByteData? byteData =
//         await (image.toByteData(format: ui.ImageByteFormat.png));
//     if (byteData != null) {
//       final time = DateTime.now().millisecond;
//       final name = "signature_$time.png";
//       final result = await ImageGallerySaver.saveImage(
//           byteData.buffer.asUint8List(),
//           quality: 100,
//           name: name);
//       print(result);
//       _toastInfo(result.toString());
//
//       final isSuccess = result['isSuccess'];
//       signatureGlobalKey.currentState!.clear();
//       if (isSuccess) {
//         await Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (BuildContext context) {
//               return Scaffold(
//                 appBar: AppBar(),
//                 body: Center(
//                   child: Container(
//                     color: Colors.grey[300],
//                     child: Image.memory(byteData.buffer.asUint8List()),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       }
//     }
//   }
//
//   _toastInfo(String info) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(info),
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//             padding: EdgeInsets.all(10),
//             child: Container(
//                 child: SfSignaturePad(
//                     key: signatureGlobalKey,
//                     backgroundColor: Colors.white,
//                     strokeColor: Colors.black,
//                     minimumStrokeWidth: 3.0,
//                     maximumStrokeWidth: 6.0),
//                 decoration:
//                     BoxDecoration(border: Border.all(color: Colors.grey)))),
//         SizedBox(height: 10),
//         Row(children: <Widget>[
//           TextButton(
//             child: Text(
//               'Save As Image',
//               style: TextStyle(fontSize: 20),
//             ),
//             onPressed: _handleSaveButtonPressed,
//           ),
//           TextButton(
//             child: Text('Clear', style: TextStyle(fontSize: 20)),
//             onPressed: _handleClearButtonPressed,
//           )
//         ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
//       ],
//     ));
//   }
// }
import 'package:demo_project/constants/K_Network.dart';
import 'package:demo_project/viewmodel/pdf_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Viewer extends StatefulWidget {
  const Viewer({super.key});

  static const routeName = 'Viewer';

  @override
  State<Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {

  @override
  Widget build(BuildContext context) {
    return Consumer<PdfViewModel>(builder: (context, viewModel, child) {
      return SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(viewModel, context),
          body: Stack(
            children: [
              _generatePdf(viewModel),
              if (viewModel.signatureImagesMap[viewModel.currentPage] != null)
                _positionSignature(viewModel),
            ],
          ),
        ),
      );
    });
  }

  Positioned _positionSignature(PdfViewModel viewModel) {
    return Positioned(
      left: viewModel.signaturePositionsMap[viewModel.currentPage]?.dx,
      top: viewModel.signaturePositionsMap[viewModel.currentPage]?.dy,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.19,
        width: MediaQuery.of(context).size.width * 0.5,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              viewModel.signaturePositionsMap[viewModel.currentPage] =
                  (viewModel.signaturePositionsMap[viewModel.currentPage] ??
                          Offset.zero) +
                      details.delta;
              print(viewModel.signaturePositionsMap[viewModel.currentPage]);
            });
          },
          child: Image.memory(
            viewModel.signatureImagesMap[viewModel.currentPage]!,
            // height: MediaQuery.of(context).size.height*0.22,
            // width: MediaQuery.of(context).size.height*0.22,
          ),
        ),
      ),
    );
  }

  Widget _generatePdf(PdfViewModel viewModel) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height*0.65,
      child: SfPdfViewer.asset(
        KNetwork.pdfAsset,
        pageLayoutMode: PdfPageLayoutMode.single,
        scrollDirection: PdfScrollDirection.vertical,
        onPageChanged: (details) {
          setState(() {
            viewModel.currentPage = details.newPageNumber - 1;
          });
        },
      ),
    );
  }

  AppBar _buildAppBar(PdfViewModel viewModel, BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            _openSignaturePad(viewModel);
          },
          icon: Icon(Icons.edit),
          tooltip: 'Open Signature Pad',
        ),
        SizedBox(width: 16.0), // Adjust the spacing between icons
        IconButton(
          onPressed: () {
            viewModel.generatePDF(context);
          },
          icon: Icon(Icons.picture_as_pdf),
          tooltip: 'Generate PDF',
        ),
      ],
    );
  }

  void _openSignaturePad(PdfViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signature Pad'),
          content: SizedBox(
            height: 200,
            width: 300,
            child: SfSignaturePad(
              key: viewModel.signaturePadKey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                viewModel.handleClearButtonPressed();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                viewModel.saveSignature();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
