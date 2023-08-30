import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 0)
class Favorite {
  @HiveField(0)
  int nik;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String alamat;

  Favorite({
    required this.nik,
    required this.firstName,
    required this.lastName,
    required this.alamat,
  });
}
