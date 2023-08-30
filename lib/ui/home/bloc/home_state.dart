part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  final bool loading;
  final bool error;
  final bool noConnection;
  final List<EmployeeData> employees;

  const HomeState({
    required this.loading,
    required this.error,
    required this.noConnection,
    required this.employees,
  });

  factory HomeState.initial() {
    return const HomeState(
        loading: true, error: false, noConnection: false, employees: []);
  }

  factory HomeState.showEmployees(List<EmployeeData> employees) {
    return HomeState(
        loading: false,
        error: false,
        noConnection: false,
        employees: employees);
  }

  factory HomeState.error() {
    return const HomeState(
        loading: false, error: true, noConnection: false, employees: []);
  }

  factory HomeState.noConnection() {
    return const HomeState(
        loading: false, error: false, noConnection: true, employees: []);
  }

  @override
  List<Object?> get props => [loading, employees];
}
