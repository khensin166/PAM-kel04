import 'package:cis_kel04_app/views/mahasiswa/pages/dashboard.dart';
import 'package:cis_kel04_app/views/mahasiswa/pages/login.dart';
import 'package:cis_kel04_app/views/startPage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    // final token = box.read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cis App',
      home: const StartPage(),
      // home: token == null ? const MhsLogin() : const MhsDashboard(),
    );
  }
}
