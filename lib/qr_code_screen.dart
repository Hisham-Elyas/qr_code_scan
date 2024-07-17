import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_code_scan/qr_code_controller.dart';

import 'custom_text_form_field_widget.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Page')),
      body: GetBuilder<QrCodeMyController>(
        builder: (controller) => Center(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: PrettyQrView.data(
                    data: controller.qrCode,
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextFormFieldWidget(
                  labelText: 'الحساب الكلي',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل رقم صالح';
                      // return 'ادخل الحساب الكلي';
                    } else if (!GetUtils.isNum(value)) {
                      return 'ادخل رقم ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.total = value!;
                  },
                ),
                // Text(
                //   controller.gnQRCode(),
                //   style: const TextStyle(fontWeight: FontWeight.bold),
                // ),
                ElevatedButton(
                  onPressed: () {
                    controller.submit();
                  },
                  child: const Text('Gn QRCode'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
