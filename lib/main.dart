import 'package:flutter/material.dart';
import 'package:novo_projeto/data/data_inherited.dart';
import 'package:novo_projeto/screens/initial_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TaskInherited(child: InitialScreen()),
    );
  }
}





