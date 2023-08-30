import 'package:company_roster/data/entity/favorite.dart';
import 'package:company_roster/di/injection.dart';
import 'package:company_roster/routes/app_router.dart';
import 'package:company_roster/ui/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  configureDependencies();

  await Hive.initFlutter();
  Hive.registerAdapter<Favorite>(FavoriteAdapter());
  await Hive.openBox<Favorite>('favorite');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.instance.get<HomeCubit>())
      ],
      child: MaterialApp.router(
        title: 'Company Roster',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff5AE4A7)),
          useMaterial3: true,
        ),
        routerConfig: AppRouter().config(),
      ),
    );
  }
}
