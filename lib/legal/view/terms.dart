import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/reusable_widgets/appBar.dart';


class TermsNConditions extends StatefulWidget {

  const TermsNConditions({super.key});

  @override
  State<TermsNConditions> createState() => _TermsNConditionsState();
}

class _TermsNConditionsState extends State<TermsNConditions> {
  Future<PDFDocument>? _documentFuture;

  @override
  void initState() {
    super.initState();
    _documentFuture = loadDocument();
  }

  Future<PDFDocument> loadDocument() async {
    return await PDFDocument.fromAsset(AssetPath.legal_terms);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(showImage: false,
        title: "Terms & Conditions",
        fontSize: 14,
      ),
      body: FutureBuilder<PDFDocument>(
        future: _documentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('No document found'),
            );
          }

          return PDFViewer(
            document: snapshot.data!,
            lazyLoad: false,
            zoomSteps: 1,
            numberPickerConfirmWidget: const Text(
              "Confirm",
            ),
          );
        },
      ),
    );
  }
}
