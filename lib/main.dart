import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_code_scan/invs_model.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() => runApp(const MaterialApp(home: MyHome()));

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @protected
  late QrImage qrImage;

  @override
  void initState() {
    super.initState();

    final qrCode = QrCode(
      8,
      QrErrorCorrectLevel.H,
    )..addData('lorem ipsum dolor sit amet');

    qrImage = QrImage(qrCode);
  }

  final List<InvsModel> list = [
    InvsModel("Calvin Rios 1", '81.562'),
    InvsModel("Isabella Norris 7", '61.8039'),
    InvsModel("Frederick Newman 99", '3.8868'),
    InvsModel("Lillian Jennings 34", '35.091'),
    InvsModel("Jeremiah Pope 91", '49.6203'),
    InvsModel("Edgar Banks 98", '39.7778'),
    InvsModel("Evan Harrison 11", '1.3083'),
    InvsModel("Gerald Ramos 53", '2.1709'),
    InvsModel("Barbara Watkins 61", '65.4708'),
    InvsModel("Eddie Terry 65", '2.9501'),
    InvsModel("Randy Goodman 57", '10.5765'),
    InvsModel("Billy Johnston 66", '30.8057'),
    InvsModel("Hilda Wilkerson 78", '1.7984'),
    InvsModel("Kate Barnett 40", '10.9586'),
    InvsModel("Mina Allison 64", '90.7326'),
    InvsModel("Duane Cross 76", '78.0318'),
    InvsModel("Jayden Ingram 86", '43.8502'),
    InvsModel("Adele Collins 25", '74.2766'),
    InvsModel("Mark Howard 45", '1.957'),
    InvsModel("Lester Ramos 39", '62.669'),
    InvsModel("Birdie Brown 16", '98.2954'),
    InvsModel("Manuel Morton 42", '99.1526'),
  ];
  final InvList list2 = InvList(list: [
    InvsModel("Calvin Rios 1", '81.562'),
    InvsModel("Isabella Norris 7", '61.8039'),
    InvsModel("Frederick Newman 99", '3.8868'),
    InvsModel("Lillian Jennings 34", '35.091'),
    InvsModel("Jeremiah Pope 91", '49.6203'),
    InvsModel("Edgar Banks 98", '39.7778'),
    InvsModel("Evan Harrison 11", '1.3083'),
    InvsModel("Gerald Ramos 53", '2.1709'),
    InvsModel("Barbara Watkins 61", '65.4708'),
    InvsModel("Eddie Terry 65", '2.9501'),
    InvsModel("Randy Goodman 57", '10.5765'),
    InvsModel("Billy Johnston 66", '30.8057'),
    InvsModel("Hilda Wilkerson 78", '1.7984'),
    InvsModel("Kate Barnett 40", '10.9586'),
    InvsModel("Mina Allison 64", '90.7326'),
    InvsModel("Duane Cross 76", '78.0318'),
    InvsModel("Jayden Ingram 86", '43.8502'),
    InvsModel("Adele Collins 25", '74.2766'),
    InvsModel("Mark Howard 45", '1.957'),
    InvsModel("Lester Ramos 39", '62.669'),
    InvsModel("Birdie Brown 16", '98.2954'),
    InvsModel("Manuel Morton 42", '99.1526'),
  ]);
  @override
  Widget build(BuildContext context) {
    log(list2.toString());
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: PrettyQrView.data(
                data: list
                    .toString()
                    .replaceAll(',', '')
                    .replaceAll('[', '')
                    .replaceAll(']', ''),
                // data:
                //     "فاتورة\n متجر الرياض \n رقم الفاتورة :#34567 \n عنوان المتجر : الرياض \n المنتجات \n بوكية ورد \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t 150 ريال",
                decoration: const PrettyQrDecoration(
                    // image: PrettyQrDecorationImage(
                    //     // image: AssetImage('/'),
                    //     ),
                    ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewExample(),
                ));
              },
              child: const Text('qrView'),
            ),
          ],
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
