import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/services/api_service.dart';
import 'package:myapp/bloc/album_bloc.dart';
import 'app_router.dart';

void main() {
  final apiService = ApiService();
  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;

  const MyApp({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumBloc(apiService),
      child: MaterialApp.router(
        title: 'Album Viewer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF128FFC),
            primary: const Color(0xFF128FFC),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF128FFC),
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF128FFC),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}