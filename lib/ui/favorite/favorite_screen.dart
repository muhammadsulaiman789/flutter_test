import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:company_roster/data/entity/favorite.dart';
import 'package:company_roster/data/response/employee_response.dart';
import 'package:company_roster/ui/home/widgets/employee_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Favorite>('favorite').listenable(),
        builder: (context, Box<Favorite> box, _) {
          if (box.values.isEmpty) {
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
                  const Text("Favorite is Empty"),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                var employee = EmployeeData.fromEntity(box.getAt(index)!);
                var color = Color((Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0);
                return EmployeeItem(employee: employee, color: color);
              },
              itemCount: box.values.length,
            );
          }
        },
      ),
    );
  }
}
