import 'package:cargaproductos/config/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/constants/environment.dart';

void main() async {
  await Environment.initEnvironment();
  runApp(
     ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(Environment.apiUrl); // Debugg
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      
    );
  }
}
