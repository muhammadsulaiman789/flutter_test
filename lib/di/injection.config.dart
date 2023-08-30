// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:company_roster/data/company_roster_repository.dart' as _i5;
import 'package:company_roster/data/source/company_roster_api.dart' as _i3;
import 'package:company_roster/di/module/connection_checker_module.dart' as _i8;
import 'package:company_roster/ui/form/bloc/employee_form_cubit.dart' as _i6;
import 'package:company_roster/ui/home/bloc/home_cubit.dart' as _i7;
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart'
    as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final connectionCheckerModule = _$ConnectionCheckerModule();
    gh.singleton<_i3.CompanyRosterApi>(_i3.CompanyRosterApi());
    gh.singleton<_i4.DataConnectionChecker>(
        connectionCheckerModule.connectionChecker());
    gh.factory<_i5.CompanyRosterRepository>(() => _i5.CompanyRosterRepository(
          rosterApi: gh<_i3.CompanyRosterApi>(),
          connectionChecker: gh<_i4.DataConnectionChecker>(),
        ));
    gh.factory<_i6.EmployeeFormCubit>(() =>
        _i6.EmployeeFormCubit(repository: gh<_i5.CompanyRosterRepository>()));
    gh.factory<_i7.HomeCubit>(
        () => _i7.HomeCubit(repository: gh<_i5.CompanyRosterRepository>()));
    return this;
  }
}

class _$ConnectionCheckerModule extends _i8.ConnectionCheckerModule {}
