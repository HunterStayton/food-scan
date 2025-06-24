import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../models/calorie_data.dart';
import '../models/food_item.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QRScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  String _selectedCategory = 'Breakfast';

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? cameraController;
  Barcode? result;

  @override
  void reassemble(){
    super.reassemble();
    if(Platform.isAndroid){
      cameraController!.pauseCamera();
    } else if (Platform.isIOS){
      cameraController!.resumeCamera();
    }
  }

  final List<String> _categories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                  'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _addFood() {
    if (_formKey.currentState?.validate() ?? false) {
      final food = FoodItem(
        name: _nameController.text,
        calories: int.parse(_caloriesController.text),
        category: _selectedCategory,
        dateAdded: DateTime.now(),
        carbs: 0,
        fat: 0,
        protein: 0,
      );

      CalorieData.addFood(food);

      _nameController.clear();
      _caloriesController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Food added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.cameraController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }



  @override
  void dispose() {
    cameraController?.dispose();
    _nameController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }
}

