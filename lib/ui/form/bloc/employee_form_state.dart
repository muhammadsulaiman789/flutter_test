part of 'employee_form_cubit.dart';

@immutable
class EmployeeFormState extends Equatable {
  final bool loading;
  final bool success;
  final bool error;
  final bool noConnection;
  final String? errorMessage;

  const EmployeeFormState({
    required this.loading,
    required this.success,
    required this.error,
    required this.noConnection,
    this.errorMessage,
  });

  factory EmployeeFormState.initial() {
    return const EmployeeFormState(
        loading: false, success: false, error: false, noConnection: false);
  }

  factory EmployeeFormState.updateStatus(
    bool loading,
    bool success,
    bool error,
    bool noConnection, {
    String? errorMessage,
  }) {
    return EmployeeFormState(
      loading: loading,
      success: success,
      error: error,
      noConnection: noConnection,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [loading, success];
}
