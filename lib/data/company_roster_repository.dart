import 'package:company_roster/data/response/employee_response.dart';
import 'package:company_roster/data/result.dart';
import 'package:company_roster/data/source/company_roster_api.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyRosterRepository {
  final CompanyRosterApi rosterApi;
  final DataConnectionChecker connectionChecker;

  CompanyRosterRepository({
    required this.rosterApi,
    required this.connectionChecker,
  });

  Future<Result<List<EmployeeData>>> loadEmployees() async {
    try {
      if (await connectionChecker.hasConnection) {
        var result = await rosterApi.loadEmployees();
        var response = EmployeeResponse.fromJson(result.data);
        return Result(resultType: ResultType.success, data: response.values);
      } else {
        return Result(resultType: ResultType.noConnection);
      }
    } catch (e) {
      return Result(resultType: ResultType.error);
    }
  }

  Future<Result> insertEmployee(List<EmployeeData> employee) async {
    try {
      if (await connectionChecker.hasConnection) {
        await rosterApi.inputNewEmployee(employee);
        return Result(resultType: ResultType.success);
      } else {
        return Result(resultType: ResultType.noConnection);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 500) {
          return Result(resultType: ResultType.error, message: "nik");
        } else if (e.response!.statusCode == 400) {
          return Result(resultType: ResultType.error, message: "large_nik");
        }
      }
      return Result(resultType: ResultType.error, message: "other");
    }
  }
}
