import "package:flutter/material.dart";
import 'package:crud_sqlite/listData.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kejaksaan Tinggi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ListMahasiswa(),
      debugShowCheckedModeBanner: false,
    );
  }
}
