import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../network/endpoints.dart';
import '../../services/my_loader.dart';
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
  bool loader = true;
  bool is_s = true;
  late Map<String, String> data;
  late String image;
  bool _is_error = false;
  String? _error_text;

  @override
  void initState() {
    setState(() {
      code_is = _format(url: widget.url!);
      getData();
    });
    super.initState();
  }

  Future<void> getData() async {
    setState(() {
      loader = true;
    });

    FormData formData;

    formData = FormData.fromMap({'action': 'get_member1', 'id': code_is});

    print(formData.fields);
    try {
      Response encodedData =
          await EndPoints.instanse().AdminEvent(data: formData);

      print(encodedData.data);
      if (encodedData.statusCode == 200 || encodedData.statusCode == 201) {
        if (encodedData.data['success']) {
          if (encodedData.data['data']['Agency_ID'] != null) {
            print('here 2');
            setState(() {
              is_s = true;
            });
            data = {
              'OMC Type': encodedData.data['data']['OMC_Type'].toString(),
              'Agency ID': encodedData.data['data']['Agency_ID'].toString(),
              'Agency Name': encodedData.data['data']['Agency_name']
                  .toString()
                  .toUpperCase(),
              'Mobile Number':
                  encodedData.data['data']['Mobile_Number'].toString(),
              'District': encodedData.data['data']['District'].toString(),
              'Date of Membership':
                  encodedData.data['data']['Date_of_Membership'].toString(),
              'Email': encodedData.data['data']['Email_Address'].toString(),
              'Mobile': encodedData.data['data']['Mobile_Number'].toString(),
              'Address': encodedData.data['data']['Address'].toString(),
            };
            image = encodedData.data['data']['qrcode'].toString();
            print('Data is: ${data}');
            setState(() {
              loader = false;
            });
            return;
          } else {
            setState(() {
              is_s = false;
            });
            data = {};
            print('here');
            data = {
              'Agency Name': encodedData.data['data']['name'].toString(),
              'Company Name':
                  encodedData.data['data']['company_name'].toString(),
              'Designation': encodedData.data['data']['designation'].toString(),
            };
            setState(() {
              loader = false;
            });
            return;
          }
        } else {
          AppDialog.instance().infoDialog(
              context: context,
              title: 'Success: False',
              content: encodedData.data['message']);
          setState(() {
            loader = false;
            _is_error = true;
            _error_text = encodedData.data['message'];
          });
        }
      } else {
        setState(() {
          loader = false;
          _is_error = true;
        });
        AppDialog.instance().infoDialog(
            context: context,
            title: 'Some Error Occur-1',
            content: 'Please Contact Admin');
      }
      setState(() {
        _is_error = true;
        loader = false;
      });
    } catch (e) {
      setState(() {
        loader = false;
        _is_error = true;
      });
      AppDialog.instance().infoDialog(
          context: context,
          title: 'Some Error Occur',
          content: 'Please Contact Admin}',
          onActionPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
    }
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
      body: loader
          ? const MyLoader()
          : _is_error
              ? _error_widget()
              : _build_ui(),
    );
  }

  Widget _error_widget() {
    return Center(
      child: _error_text == null
          ? const Text('Some Error Occur From Backend')
          : Text(_error_text!),
    );
  }

  Widget _build_ui() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            // _attendance_illustration(),
            _buildInfoCard(data),
            // Text(
            //   'Secret Key (hidden): ${code_is}',
            //   style: const TextStyle(
            //       fontSize: 16, fontWeight: FontWeight.w600),
            // ),
            _build_buttons(context, data, is_s),
          ],
        ),
      ),
    );
  }

  Widget _build_buttons(
      BuildContext context, Map<String, String> data, bool is_s) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            AppDialog.instance().confDialog(
              context: context,
              title: 'Attendance Mark?',
              content:
                  'Are you sure you would like to confirm your attendance?',
              onActionPressed: () async {
                Navigator.of(context).pop();

                try {
                  // Create FormData with conditional fields based on `is_s`
                  FormData data1 = FormData.fromMap({
                    'action': 'event_attendance',
                    'event_id': '22',
                    'type': 'member',
                    'name': data['Agency Name'] ?? '',
                    'company_name': data['Agency Name'] ?? '',
                    'email': data['Email'] ?? '',
                    'mobile': data['Mobile'] ?? '',
                    'address': data['Address'] ?? '',
                    'agency_id': data['Agency ID'] ?? '',
                    if (!is_s) 'designation': data['Designation'] ?? '',
                  });

                  print(data1.fields);

                  Response response =
                      await EndPoints.instanse().AdminEvent(data: data1);
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    AppDialog.instance().infoDialog(
                      context: context,
                      title:
                          response.data['success'] ? 'Success' : 'Unsuccessful',
                      content: response.data['message'],
                      onActionPressed: () {
                        Navigator.of(context).pop(); // Close info dialog
                        Navigator.of(context)
                            .pop(); // Close the attendance dialog
                      },
                    );
                  }
                } catch (e) {
                  setState(() {
                    loader = false;
                    _is_error = true;
                  });
                }
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.instance().red,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
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
    const baseUrl = 'https://tlda.org.in/api/';

    // Check if the URL starts with the base URL
    if (url.startsWith(baseUrl)) {
      // Extract the part after the base URL
      return url.replaceFirst(baseUrl, '');
    }


    // If the URL doesn't start with the base URL, return an error message
    return 'Invalid URL';
  }

  Widget _buildInfoCard(Map<String, String> data) {
    return Column(
      children: data.entries.map((entry) {
        return Column(
          children: [
            Visibility(
              visible: entry.value.toString() != 'null' &&
                  entry.value.toString() != '' &&
                  entry.value.toString() != '0000-00-00',
              child: Card(
                color: Colors.white,
                elevation: 5,
                shadowColor: AppColor.instance().red,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Display the key (left side)
                      Text(
                        entry.key,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColor.instance().lightBlue,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      // Display the value (right side)
                      Flexible(
                        child: Text(
                          entry.value.replaceAll(',', '\n'),
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColor.instance().black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        );
      }).toList(),
    );
  }
}
