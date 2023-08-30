import 'dart:convert';

import 'package:company_roster/core/utils/base_api_provider.dart';
import 'package:company_roster/data/response/employee_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class CompanyRosterApi extends BaseApiProvider {
  @override
  String baseUrl() =>
      'https://tiraapi-dev.tigaraksa.co.id/tes-programer-mobile/';

  Future<Response> loadEmployees() async {
    return dio.get('api/karyawan/all');
  }

  Future<Response> inputNewEmployee(List<EmployeeData> employee) async {
    return dio.post('karyawan/insert', data: jsonEncode(employee));
  }
}
