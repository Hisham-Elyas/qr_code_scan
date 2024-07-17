import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class QrCodeMyController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  String total = '0.00';
  String qrCode = 'مرحبا بيك ادخل حساب الكلي لتوليد QRCode';
  Future<void> submit() async {
    Get.focusScope!.unfocus();
    if (!formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    formKey.currentState!.save();
    qrCode = gnQRCode();
    update();
  }

  gnQRCode() {
    return 'متجر الرياض \n رقم الفاتورة : #${Random().nextInt(9999)}\n التاريخ : ${Jiffy.now().yMMMMEEEEdjm} \n الحساب الكلي : \$$total';
  }
}
