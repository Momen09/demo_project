import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:demo_project/constants/K_Network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Viewer extends StatefulWidget {
  const Viewer({super.key});
  static const routeName = 'Viewer';

  @override
  State<Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  final GlobalKey<SfSignaturePadState> _signaturePadGlobalKey = GlobalKey();
  Uint8List? _documentBytes;
  @override
  void initState() {
    super.initState();
  }
  //Add the signature in the PDF document.
  void _handleSigningProcess() async {

    //Save the signature as PNG image.
    final data =
    await _signaturePadGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    ByteData certBytes = await rootBundle.load("assets/pdf/certificate.pfx");
    final Uint8List certificateBytes = certBytes.buffer.asUint8List();
    final String pdfUrl = KNetwork.pdfUrl;
    final response = await http.get(Uri.parse(pdfUrl));
    Uint8List _documentBytes = response.bodyBytes;

// Load the document
    PdfDocument document = PdfDocument(inputBytes: _documentBytes);
    //Get the first page of the document. The page in which signature need to be added.
    PdfPage page = document.pages[0];

    //Create a digital signature and set the signature information.
    PdfSignatureField signatureField = PdfSignatureField(page, 'signature',
        bounds: const Rect.fromLTRB(300, 500, 550, 700),
        signature: PdfSignature(
          //Create a certificate instance from the PFX file with a private key.
            certificate: PdfCertificate(certificateBytes, 'password123'),
            contactInfo: 'johndoe@owned.us',
            locationInfo: 'Honolulu, Hawaii',
            reason: 'I am author of this document.',
            digestAlgorithm: DigestAlgorithm.sha256,
            cryptographicStandard: CryptographicStandard.cms));

    //Get the signature field appearance graphics.
    PdfGraphics? graphics = signatureField.appearance.normal.graphics;

    //Draw the signature image in the PDF page.
    graphics?.drawImage(PdfBitmap(bytes!.buffer.asUint8List()),
        const Rect.fromLTWH(0, 0, 250, 200));

    //Add a signature field to the form.
    document.form.fields.add(signatureField);

    //Flatten the PDF form field annotation
    document.form.flattenAllFields();

    _documentBytes = Uint8List.fromList(document.save() as List<int>);
    document.dispose();
    setState(() {});
  }

  //Clear the signature in the SfSignaturePad.
  void _handleClearButtonPressed() {
    _signaturePadGlobalKey.currentState!.clear();
  }
  void _loadAndDisplayPdf() {
    // Check if _documentBytes is not null
    if (_documentBytes != null) {
      // Create a PdfDocument from the signed PDF bytes
      PdfDocument document = PdfDocument(inputBytes: _documentBytes!);

      // Display the PDF in the viewer
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Signed PDF Viewer'),
            ),
            body: SfPdfViewer.memory(
              _documentBytes!,
              canShowPaginationDialog: true,
            ),
          ),
        ),
      );

      // Dispose of the PdfDocument
      document.dispose();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Signature Pad'),
      ),
      body: Column(
        children: [
          // Add your signature pad widget
          SfSignaturePad(
            key: _signaturePadGlobalKey,
            // Add properties and customization for your signature pad
          ),
          // Add a button to initiate the signing process
          ElevatedButton(
            onPressed: () {
              _handleSigningProcess();
              _loadAndDisplayPdf(); // Load and display the signed PDF
            },
            child: Text('Sign PDF'),
          ),
          // Add a button to clear the signature pad
          ElevatedButton(
            onPressed: _handleClearButtonPressed,
            child: Text('Clear Signature'),
          ),
        ],
      ),
    );
  }
}
