// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:signature/signature.dart';
//
//
// class PdfViewer extends StatefulWidget {
//   final String pdfPath;
//
//   PdfViewer({required this.pdfPath});
//
//   @override
//   _PdfViewerState createState() => _PdfViewerState();
// }
//
// class _PdfViewerState extends State<PdfViewer> {
//   final SignatureController _controller = SignatureController(
//     penStrokeWidth: 5,
//     penColor: Colors.black,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer with Signature'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: PDFView(
//               filePath: widget.pdfPath,
//               enableSwipe: true,
//               autoSpacing: false,
//               pageSnap: true,
//               pageFling: false,
//               onRender: (pages) {
//                 print("Rendered $pages pages.");
//               },
//               onError: (error) {
//                 print(error.toString());
//               },
//             ),
//           ),
//           Container(
//             height: 200,
//             color: Colors.grey[200],
//             child: Signature(
//               controller: _controller,
//               height: 180,
//               backgroundColor: Colors.white,
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               // Save the signature as an image
//               final signatureImage = await _controller.toPngBytes();
//               // Do something with the signatureImage, like saving it or processing it
//               // You can also pass this signatureImage to your PDF generator
//             },
//             child: Text('Save Signature'),
//           ),
//         ],
//       ),
//     );
//   }
// }
