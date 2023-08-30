import 'package:company_roster/ui/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchEmployeeAppBar extends StatelessWidget {
  const SearchEmployeeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff5AE4A7).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Search Employee',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          context.read<HomeCubit>().searchEmployee(value);
        },
      ),
    );
  }
}
