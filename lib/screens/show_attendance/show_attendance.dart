import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lpg_qr/network/models/show_attendance_model.dart';

import '../../network/endpoints.dart';
import '../../utils/app_color.dart';
import '../../utils/app_dialog.dart';

class ShowAttendance extends StatefulWidget {
  const ShowAttendance({super.key});

  @override
  State<ShowAttendance> createState() => _ShowAttendanceState();
}

class _ShowAttendanceState extends State<ShowAttendance> {
  bool loader = true;
  bool isError = false;
  String? errorText;
  late ShowAttendanceModel showAttendanceModel;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.instance().red,
          title: const Text(
            'Show Attendance',
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
            ? Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppColor.instance().red,
                ),
              )
            : _show_card());
  }

  Future<void> getData() async {
    setState(() {
      loader = true;
    });
    FormData formData = FormData.fromMap(
        {'action': 'get_attendance', 'event_id': '23', 'type': 'member'});

    try {
      Response encodedData =
          await EndPoints.instanse().AdminEvent(data: formData);

      if (encodedData.statusCode == 200 || encodedData.statusCode == 201) {
        if (encodedData.data['success']) {
          showAttendanceModel = ShowAttendanceModel.fromJson(encodedData.data);
        } else {
          setState(() {
            isError = true;
            errorText = encodedData.data['message'];
          });
          AppDialog.instance().infoDialog(
              context: context,
              title: 'Info',
              content: encodedData.data['message']);
        }
      } else {
        setState(() {
          isError = true;
        });
      }
      setState(() {
        loader = false;
      });
    } catch (e) {
      setState(() {
        loader = false;
        isError = true;
      });
      AppDialog.instance().infoDialog(
          context: context,
          title: 'Some Error Occur',
          content: 'Please Contact Admin: ${e.toString()}');
    }
  }

  Widget _show_card() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: loader
          ? _progress_indicator()
          : isError
              ? _error_widget()
              : _display_list(),
    );
  }

  Widget _progress_indicator() {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColor.instance().red,
      ),
    );
  }

  Widget _error_widget() {
    return Center(
      child: errorText == null
          ? const Text('Some Error Occur From Backend')
          : Text(errorText!),
    );
  }

  Widget _display_list() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total Entry: ${showAttendanceModel.data?.length}',
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: showAttendanceModel.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shadowColor: AppColor.instance().red,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        _show_row(
                            left: 'OMC Type: ',
                            right: showAttendanceModel.data![index].oMCType
                                .toString()),
                        _show_row(
                            left: 'Id: ',
                            right:
                                showAttendanceModel.data![index].iD.toString()),
                        _show_row(
                            left: 'Name: ',
                            right: showAttendanceModel.data![index].name
                                .toString()),
                        _show_row(
                            left: 'Email: ',
                            right: showAttendanceModel.data![index].email
                                .toString()),
                        _show_row(
                            left: 'Address: ',
                            right: showAttendanceModel.data![index].address
                                .toString()),
                        _show_row(
                            left: 'agencyId: ',
                            right: showAttendanceModel.data![index].agencyId
                                .toString()),
                        _show_row(
                            left: 'Type: ',
                            right: showAttendanceModel.data![index].type
                                .toString()),
                        _show_row(
                            left: 'District: ',
                            right: showAttendanceModel.data![index].district
                                .toString()),
                        // _show_row(left: 'agencyId: ', right: showAttendanceModel.data![index].agencyId.toString()),
                        // Text(showAttendanceModel.data![index].iD.toString()),
                        // Text(showAttendanceModel.data![index].email.toString()),
                        // Text(showAttendanceModel.data![index].address.toString()),
                        // Text(showAttendanceModel.data![index].agencyId.toString()),
                        // Text(showAttendanceModel.data![index].name.toString()),
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }


  Widget _show_row({required String left, required String right}) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.,
      children: [
        // Display the key (left side)
        Text(
          left,
          style: TextStyle(
              fontSize: 16,
              color: AppColor.instance().lightBlue,
              fontWeight: FontWeight.w700),
        ),
        // Display the value (right side)
        Flexible(
          child: Text(
            right,
            style: TextStyle(
                fontSize: 14,
                color: AppColor.instance().black,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
