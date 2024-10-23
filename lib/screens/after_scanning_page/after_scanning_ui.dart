import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_dialog.dart';

class AfterScanningUi extends StatefulWidget {
  String? url;
  AfterScanningUi({super.key, required String this.url});

  @override
  State<AfterScanningUi> createState() => _AfterScanningUiState();
}

class _AfterScanningUiState extends State<AfterScanningUi> {
  String code_is = '';

  @override
  void initState() {
    setState(() {
      code_is = _format(url: widget.url!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.instance().background,
      appBar: AppBar(
        backgroundColor: AppColor.instance().red,
        title: const Text(
          'Event Attendance Mark',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05),
              _attendance_illustration(),
              Text(
                'Secret Key (hidden): ${code_is}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              _build_buttons()
            ],
          ),
        ),
      ),
    );
  }

  Widget _attendance_illustration() {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: SvgPicture.asset(AppAssets.instance().svg_attendance));
  }

  Widget _build_buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            AppDialog.instance().infoDialog(
                context: context,
                title: 'Working',
                content: 'Comming Soon...',
                onActionPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.instance().red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Confirm Attendance',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  String _format({required String url}) {
    const baseUrl = 'https://lpgassociation.pmpframe.com/';

    // Check if the URL starts with the base URL
    if (url.startsWith(baseUrl)) {
      // Extract the part after the base URL
      return url.replaceFirst(baseUrl, '');
    }

    // If the URL doesn't start with the base URL, return an error message
    return 'Invalid URL';
  }

  // Widget _buildInfoCard(Map<String, String> data) {
  //   return Column(
  //     children: data.entries.map((entry) {
  //       return Column(
  //         children: [
  //           Card(
  //             color: Colors.white,
  //             elevation: 5,
  //             shadowColor: AppColor.instance().red,
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   // Display the key (left side)
  //                   Text(
  //                     entry.key,
  //                     style: TextStyle(
  //                         fontSize: 16,
  //                         color: AppColor.instance().lightBlue,
  //                         fontWeight: FontWeight.w700),
  //                   ),
  //                   const SizedBox(
  //                     width: 20,
  //                   ),
  //                   // Display the value (right side)
  //                   Flexible(
  //                     child: Text(
  //                       entry.value.replaceAll(',', '\n'),
  //                       style: TextStyle(
  //                           fontSize: 14,
  //                           color: AppColor.instance().black,
  //                           fontWeight: FontWeight.w700),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 5,
  //           ),
  //         ],
  //       );
  //     }).toList(),
  //   );
  // }
}
