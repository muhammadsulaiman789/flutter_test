import 'package:auto_route/auto_route.dart';
import 'package:company_roster/core/widgets/text_edit_field.dart';
import 'package:company_roster/data/response/employee_response.dart';
import 'package:company_roster/ui/form/bloc/employee_form_cubit.dart';
import 'package:company_roster/ui/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class EmployeeFormScreen extends StatefulWidget {
  const EmployeeFormScreen({super.key});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final formKey = GlobalKey<FormState>();

  final nikController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();

  bool autoValidate = false;
  EmployeeData employee = EmployeeData();

  @override
  void dispose() {
    nikController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeFormCubit>(
      create: (context) => GetIt.instance.get<EmployeeFormCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('New Employee'), elevation: 1,),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                spreadRadius: 1,
                blurRadius: 1,
                color: Colors.black12,
              ),
            ],
          ),
          child: BlocConsumer<EmployeeFormCubit, EmployeeFormState>(
            listener: (context, state) {
              if (state.noConnection) {
                showStatusDialog(false, true, "");
              } else if (state.error) {
                showStatusDialog(true, false, state.errorMessage!);
              } else if (state.success) {
                context.read<HomeCubit>().loadEmployees();
                showStatusDialog(false, false, "");
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    employee = EmployeeData(
                      nik: int.parse(nikController.text),
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      alamat: addressController.text,
                      aktif: true,
                    );

                    var employees = <EmployeeData>[];
                    employees.add(employee);

                    context.read<EmployeeFormCubit>().inputEmployee(employees);
                  } else {
                    setState(() {
                      autoValidate = true;
                    });
                  }
                },
                child: state.loading
                    ? const CircularProgressIndicator()
                    : const Text('Input'),
              );
            },
          ),
        ),
        body: Form(
          key: formKey,
          autovalidateMode: autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextEditField(
                  hint: 'NIK',
                  controller: nikController,
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please input your NIK";
                    } else {
                      return null;
                    }
                  },
                ),
                TextEditField(
                  hint: 'First Name',
                  controller: firstNameController,
                  capitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please input your first name";
                    } else {
                      return null;
                    }
                  },
                ),
                TextEditField(
                  hint: 'Last Name',
                  controller: lastNameController,
                  capitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please input your last name";
                    } else {
                      return null;
                    }
                  },
                ),
                TextEditField(
                  hint: 'Address',
                  controller: addressController,
                  inputType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please input your address";
                    } else {
                      return null;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showStatusDialog(bool error, bool noConnection, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: error || noConnection
                        ? Colors.redAccent
                        : Colors.lightGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    error || noConnection ? Icons.close : Icons.check,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  dialogMessage(error, noConnection, message),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (error || noConnection) {
                      context.router.pop();
                    } else {
                      context.router.popUntil(
                          (route) => route.settings.name == "HomeRoute");
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        });
  }

  String dialogMessage(bool error, bool noConnection, String message) {
    if (error) {
      if (message == "nik") {
        return "NIK is already exist, please change it";
      } else if (message == "large_nik") {
        return "NIK is too large";
      } else {
        return "There something wrong when insert employee";
      }
    } else if (noConnection) {
      return "Your device not connected to internet";
    } else {
      return "Success Save Employee Data";
    }
  }
}
