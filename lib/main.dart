import 'package:flutter/material.dart';
import 'package:flutter_news_app/feature/home/home_view.dart';
import 'package:flutter_news_app/product/initialize/app_builder.dart';
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
    return MaterialApp(
      title: 'Flutter News App',
      builder: (context, child) => AppBuilder(child).build(),
      home: const HomeView(),
    );
  }
}
