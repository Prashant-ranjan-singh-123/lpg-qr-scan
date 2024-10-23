import 'package:flutter/material.dart';

class haha extends StatefulWidget {
  String? url_is;
  haha({super.key, required this.url_is});

  @override
  State<haha> createState() => _hahaState();
}

class _hahaState extends State<haha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.url_is??'No Data'),),
    );
  }
}
