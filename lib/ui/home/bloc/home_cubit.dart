import 'package:bloc/bloc.dart';
import 'package:company_roster/data/company_roster_repository.dart';
import 'package:company_roster/data/response/employee_response.dart';
import 'package:company_roster/data/result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final CompanyRosterRepository repository;

  var employees = <EmployeeData>[];
  var searchedEmployees = <EmployeeData>[];

  HomeCubit({required this.repository}) : super(HomeState.initial());

  Future<void> loadEmployees() async {
    emit(HomeState.initial());
    var result = await repository.loadEmployees();
    if (result.resultType == ResultType.success) {
      employees = result.data ?? [];
      searchedEmployees = result.data ?? [];
      emit(HomeState.showEmployees(searchedEmployees));
    } else if (result.resultType == ResultType.noConnection) {
      emit(HomeState.noConnection());
    } else {
      emit(HomeState.error());
    }
  }

  Future<void> searchEmployee(String term) async {
    if (term.isNotEmpty) {
      var result = searchedEmployees.where((element) {
        var name = "${element.firstName} ${element.lastName}";
        return name.toLowerCase().contains(term.toLowerCase());
      }).toList();
      employees = result;
      emit(HomeState.showEmployees(result));
    } else {
      emit(HomeState.showEmployees(searchedEmployees));
    }
  }
}
