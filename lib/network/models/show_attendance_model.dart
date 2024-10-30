class ShowAttendanceModel {
  bool? success;
  List<Data>? data;

  ShowAttendanceModel({this.success, this.data});

  ShowAttendanceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? iD;
  int? eventId;
  int? agencyId;
  String? type;
  String? name;
  String? companyName;
  String? email;
  String? mobile;
  String? address;
  String? designation;
  String? paymentType;
  String? transactionId;
  int? status;
  int? passStatus;
  String? datetime;
  String? oMCType;
  String? district;

  Data(
      {this.iD,
        this.eventId,
        this.agencyId,
        this.type,
        this.name,
        this.companyName,
        this.email,
        this.mobile,
        this.address,
        this.designation,
        this.paymentType,
        this.transactionId,
        this.status,
        this.passStatus,
        this.datetime,
        this.oMCType,
        this.district});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    eventId = json['event_id'];
    agencyId = json['agency_id'];
    type = json['type'];
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['Address'];
    designation = json['designation'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    status = json['status'];
    passStatus = json['pass_status'];
    datetime = json['datetime'];
    oMCType = json['OMC_Type'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['event_id'] = this.eventId;
    data['agency_id'] = this.agencyId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['Address'] = this.address;
    data['designation'] = this.designation;
    data['payment_type'] = this.paymentType;
    data['transaction_id'] = this.transactionId;
    data['status'] = this.status;
    data['pass_status'] = this.passStatus;
    data['datetime'] = this.datetime;
    data['OMC_Type'] = this.oMCType;
    data['district'] = this.district;
    return data;
  }
}
