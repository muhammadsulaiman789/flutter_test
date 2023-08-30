import 'package:bloc/bloc.dart';
import 'package:company_roster/data/company_roster_repository.dart';
import 'package:company_roster/data/response/employee_response.dart';
import 'package:company_roster/data/result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'employee_form_state.dart';

@injectable
class EmployeeFormCubit extends Cubit<EmployeeFormState> {
  final CompanyRosterRepository repository;

  EmployeeFormCubit({required this.repository})
      : super(EmployeeFormState.initial());

  Future<void> inputEmployee(List<EmployeeData> employee) async {
    emit(EmployeeFormState.updateStatus(true, false, false, false));

    var result = await repository.insertEmployee(employee);
    print("result input ${result.resultType}");
    if (result.resultType == ResultType.success) {
      emit(EmployeeFormState.updateStatus(false, true, false, false));
    } else if (result.resultType == ResultType.noConnection) {
      emit(EmployeeFormState.updateStatus(false, false, false, true));
    } else {
      emit(EmployeeFormState.updateStatus(false, false, true, false,
          errorMessage: result.message));
    }
  }
}
