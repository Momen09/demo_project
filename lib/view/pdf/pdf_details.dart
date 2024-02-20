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
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class SignaturePreviewPage  extends StatelessWidget {
  final Uint8List signature;

  const SignaturePreviewPage({
    required Key key,
    required this.signature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: const CloseButton(),
          title: const Text('Store Signature'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: () => storeSignature(context),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Center(
          child: Image.memory(signature, width: double.infinity),
        ),
      );
  }
    Future storeSignature(BuildContext context) async {
      final status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      final time = DateTime.now().toIso8601String().replaceAll('.', ':');
      final name = 'signature_$time.png';

      final result = await ImageGallerySaver.saveImage(signature, name: name);
      final isSuccess = result['isSuccess'];
      print(result);

      if (isSuccess) {
        Navigator.pop(context);
        print("Save");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Saved to signature folder!"),));
      } else {
        print("Fail");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to to save!!"),));
      }
    }
}