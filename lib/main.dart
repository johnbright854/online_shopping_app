import 'package:flutter/material.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/screens/homepage.dart';
import 'package:online_store/screens/intro_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context)=> CartModel(), child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}

