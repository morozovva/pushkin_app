import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../provider/item_provider.dart';
import 'item_screen.dart';

class QRScreen extends StatefulWidget {
  static const routeName = "/qr-screen";
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.black,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _foundBarcode,
      ),
    );
  }

  void _foundBarcode(BarcodeCapture barcode) {
    /// open screen
    if (!_screenOpened) {
      final String code = barcode.barcodes[0].displayValue.toString();
      _screenOpened = true;

      if (Provider.of<ItemProvider>(context, listen: false).getItem(code) !=
          null) {
        Navigator.of(context)
            .popAndPushNamed(ItemScreen.routeName, arguments: code);
      } else {
        Navigator.of(context).pop();

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Неверный QR-код"),
                  content: Text(
                      "Попробуйте отсканировать другой или выберите экспонат из списка"),
                ));
      }
    }
  }
}
