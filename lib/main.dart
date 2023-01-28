import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readforme/Splash.dart';
import 'package:dcdg/dcdg.dart';
import 'auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider<Auth>(create: (_) => Auth())],
      child: MyApp(),
    ),
  ); 
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}