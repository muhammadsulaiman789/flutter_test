import 'package:company_roster/data/entity/favorite.dart';
import 'package:company_roster/data/response/employee_response.dart';
import 'package:company_roster/ui/home/widgets/employee_detail_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EmployeeItem extends StatelessWidget {
  final EmployeeData employee;
  final Color color;

  const EmployeeItem({super.key, required this.employee, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          isScrollControlled: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          builder: (_) => EmployeeDetailSheet(
            employee: employee,
            color: color,
          ),
        );
      },
      leading: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Text(
          employee.name!.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          ),
        ),
      ),
      title: Text("${employee.firstName} ${employee.lastName}"),
      subtitle: Row(
        children: [
          const Icon(Icons.location_on, size: 18),
          const SizedBox(width: 8),
          Text(
            employee.alamat!,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
      trailing: ValueListenableBuilder(
        valueListenable: Hive.box<Favorite>('favorite').listenable(),
        builder: (context, box, _) {
          return IconButton(
            onPressed: () async {
              if (box.containsKey(employee.nik)) {
                box.delete(employee.nik);
                return;
              }
              var favorite = Favorite(
                nik: employee.nik!,
                firstName: employee.firstName!,
                lastName: employee.lastName!,
                alamat: employee.alamat!,
              );
              box.put(employee.nik, favorite);
            },
            icon: Icon(
              box.containsKey(employee.nik!)
                  ? Icons.thumb_up
                  : Icons.thumb_up_alt_outlined,
            ),
          );
        },
      ),
    );
  }
}
