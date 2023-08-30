import 'package:company_roster/data/entity/favorite.dart';

class EmployeeResponse {
  bool? error;
  int? statuscode;
  List<EmployeeData>? values;

  EmployeeResponse({this.error, this.statuscode, this.values});

  EmployeeResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    statuscode = json['statuscode'];
    if (json['values'] != null) {
      values = <EmployeeData>[];
      json['values'].forEach((v) {
        values!.add(EmployeeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['statuscode'] = statuscode;
    if (values != null) {
      data['values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeData {
  int? nik;
  String? firstName;
  String? lastName;
  String? alamat;
  bool? aktif;

  String? name;

  EmployeeData({
    this.nik,
    this.firstName,
    this.lastName,
    this.alamat,
    this.aktif,
    this.name,
  });

  EmployeeData.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    alamat = json['alamat'];
    aktif = json['aktif'];
    var first = firstName!.isEmpty ? "" : firstName![0];
    var last = lastName!.isEmpty ? "" : lastName![0];
    name = "$first$last";
  }

  EmployeeData.fromEntity(Favorite favorite) {
    nik = favorite.nik;
    firstName = favorite.firstName;
    lastName = favorite.lastName;
    alamat = favorite.alamat;
    var first = favorite.firstName.isEmpty ? "" : favorite.firstName[0];
    var last = favorite.lastName.isEmpty ? "" : favorite.lastName[0];
    name = "$first$last";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nik'] = nik;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['alamat'] = alamat;
    data['aktif'] = aktif;
    return data;
  }
}
