import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:company_roster/core/widgets/shimmer_loading.dart';
import 'package:company_roster/routes/app_router.gr.dart';
import 'package:company_roster/ui/home/bloc/home_cubit.dart';
import 'package:company_roster/ui/home/widgets/employee_item.dart';
import 'package:company_roster/ui/home/widgets/search_employee_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomeCubit>().loadEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchEmployeeAppBar(),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(const FavoriteRoute());
            },
            icon: const Icon(Icons.thumb_up),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(const EmployeeFormRoute()),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.loading) {
            return ListView.builder(
              itemBuilder: (context, index) => const ShimmerLoading(
                shimmerWidth: double.infinity,
                shimmerHeight: 100,
              ),
              itemCount: 5,
            );
          } else if (state.error) {
            return _errorLoadEmployee(false);
          } else if (state.noConnection) {
            return _errorLoadEmployee(true);
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeCubit>().loadEmployees();
              },
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var employee = state.employees[index];
                  var color =
                      Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0);
                  return EmployeeItem(employee: employee, color: color);
                },
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.black12),
                itemCount: state.employees.length,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _errorLoadEmployee(bool noConnection) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 80,
            ),
          ),
          const SizedBox(height: 8),
          Text(noConnection
              ? 'Your device not connected to internet'
              : 'Something Wrong When Load Data'),
          const SizedBox(height: 16),
          Visibility(
            visible: !noConnection,
            child: ElevatedButton(
              onPressed: () {
                context.read<HomeCubit>().loadEmployees();
              },
              child: const Text('Try Again'),
            ),
          ),
        ],
      ),
    );
  }
}
