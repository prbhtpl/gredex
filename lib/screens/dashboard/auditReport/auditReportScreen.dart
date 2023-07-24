import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';

class AuditReport extends StatelessWidget {
  const AuditReport({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppToolbar(
        onPressBackButton: () {
          Navigator.pop(context);
        },
        enableBackArrow: true,
        title: "Audit Report",
        appColor: Colors.transparent,
      ),
      backgroundColor: AppColor().primaryColor,
      body: SfPdfViewer.asset("assets/pdf/pdf.pdf"),
    );
  }
}
