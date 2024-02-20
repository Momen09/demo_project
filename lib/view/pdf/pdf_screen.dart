// import 'package:demo_project/constants/K_Network.dart';
// import 'package:demo_project/viewmodel/pdf_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:signature/signature.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//
// class PDFScreen extends StatefulWidget {
//   static const routeName = 'PDFScreen';
//
//   @override
//   _PdfScreenState createState() => _PdfScreenState();
// }
//
// class _PdfScreenState extends State<PDFScreen> {
//   final ScrollController scrollController = ScrollController();
//   bool isDrawing = false;
//   List<int>? _documentBytes;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PdfViewModel>(builder: (context, pdfViewModel, child) {
//       return Scaffold(
//         appBar: _pdfAppBar(pdfViewModel),
//         body: Column(
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onPanUpdate: (details) {
//                   // Update the signature position on drag
//                   pdfViewModel.updateSignaturePosition(details.globalPosition);
//                 },
//                 child: _pdfDrag(pdfViewModel),
//               ),
//             ),
//             if (isDrawing) _signaturePad(pdfViewModel),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget _signaturePad(PdfViewModel pdfViewModel) {
//     return Container(
//       height: 100.0,
//       color: Colors.grey,
//       child: Signature(
//         controller: pdfViewModel.signatureController,
//         height: 200.0,
//         backgroundColor: Colors.grey,
//       ),
//     );
//   }
//
//   Widget _pdfDrag(PdfViewModel pdfViewModel) {
//     return Stack(
//       children: [
//         _pdfPages(pdfViewModel),
//         if (pdfViewModel.signaturesMap.containsKey(pdfViewModel.currentPage) &&
//             pdfViewModel.signaturePositionsMap
//                 .containsKey(pdfViewModel.currentPage))
//           Positioned(
//             left: pdfViewModel
//                     .signaturePositionsMap[pdfViewModel.currentPage]?.dx ??
//                 0,
//             top: pdfViewModel
//                     .signaturePositionsMap[pdfViewModel.currentPage]?.dy ??
//                 0,
//             child: Image.memory(
//                 pdfViewModel.signaturesMap[pdfViewModel.currentPage]!),
//           ),
//       ],
//     );
//   }
//
//   Widget _pdfPages(PdfViewModel pdfViewModel) {
//     return SfPdfViewer.network(
//       KNetwork.pdfUrl,
//       controller: pdfViewModel.pdfViewerController,
//       key: pdfViewModel.pdfViewerKey,
//       pageLayoutMode: PdfPageLayoutMode.single,
//       scrollDirection: PdfScrollDirection.vertical,
//       onDocumentLoaded: (PdfDocumentLoadedDetails details) {
//         _documentBytes = details.document.saveSync();
//       },
//       onPageChanged: (details) {
//         setState(() {
//           pdfViewModel.currentPage = details.newPageNumber;
//         });
//       },
//     );
//   }
//
//   AppBar _pdfAppBar(PdfViewModel pdfViewModel) {
//     return AppBar(
//       title: const Text('PDF VIEWER'),
//       actions: [
//         IconButton(
//           onPressed: () {
//             setState(() {
//               isDrawing = !isDrawing;
//             });
//           },
//           icon: const Icon(Icons.edit),
//         ),
//         IconButton(
//           onPressed: () {
//             // Save the signature for the current page
//             pdfViewModel.saveSignature();
//           },
//           icon: const Icon(Icons.save),
//         ),
//         // IconButton(
//         //   onPressed: () {
//         //     // Clear the signature
//         //     pdfViewModel.signatureController.clear();
//         //   },
//         //   icon: const Icon(Icons.clear),
//         // ),
//         // IconButton(
//         //   icon: const Icon(
//         //     Icons.download,
//         //     color: Colors.white,
//         //   ),
//         //   onPressed: () async {
//         //     if (_documentBytes != null) {
//         //       Directory directory = await getTemporaryDirectory();
//         //       String path = directory.path;
//         //       //Create the empty file.
//         //       File file = File('$path/${'sample.pdf'}');
//         //       //Write the PDF data retrieved from the SfPdfViewer.
//         //       await file.writeAsBytes(_documentBytes!, flush: true);
//         //       print(path);
//         //       OpenFile.open('$path/sample.pdf');
//         //     }
//         //   },
//         // ),
//         IconButton(
//           icon: const Icon(
//             Icons.keyboard_arrow_left,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             pdfViewModel.pdfViewerController.previousPage();
//           },
//         ),
//         IconButton(
//           icon: const Icon(
//             Icons.keyboard_arrow_right,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             pdfViewModel.pdfViewerController.nextPage();
//           },
//         ),
//       ],
//     );
//   }
//
// }
