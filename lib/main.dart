import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/network/dio_client.dart';
import 'features/matches/data/repositories/match_repository_impl.dart';
import 'features/matches/presentation/screens/home_screen.dart';

void main() {
  // Inyección de dependencias manual básica
  final dioClient = DioClient();
  final matchRepository = MatchRepositoryImpl(dioClient);

  runApp(MyApp(repository: matchRepository));
}

class MyApp extends StatelessWidget {
  final MatchRepositoryImpl repository;

  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mundial 2026',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(repository: repository),
    );
  }
}
