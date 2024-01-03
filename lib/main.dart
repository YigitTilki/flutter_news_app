import 'package:flutter/material.dart';
import 'package:flutter_news_app/feature/splash/splash_view.dart';
import 'package:flutter_news_app/product/initialize/app_start_init.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await AppStart.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter News App',
      home: SplashView(),
    );
  }
}
