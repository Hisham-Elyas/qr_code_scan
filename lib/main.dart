import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scan/qr_code_controller.dart';

import 'qr_code_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => QrCodeMyController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Qr Code Screen',
      home: const QrCodeScreen(),
    );
  }
}
