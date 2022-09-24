import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universities/providers/universities_provider.dart';
import 'package:universities/screens/home_page_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => UniversitiesProvider())
      ],
      child: MaterialApp(
        title: 'Universities',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePageScreen(),
      ),
    );
  }
}