import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController categorieController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController marqueController = TextEditingController();
  final TextEditingController quantiteController = TextEditingController();
  final TextEditingController uniteController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();

  String scannedCode = '';
  String productImage = '';

  void _onScanButtonPressed() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    ProductQueryConfiguration config = ProductQueryConfiguration(
      code,
      version: ProductQueryVersion.v3,
    );

    ProductResultV3 product = await OpenFoodAPIClient.getProductV3(config);

    setState(() {
      productImage = product.product!.imageFrontUrl!;
      scannedCode = code;
      categorieController.text = scannedCode;
      nomController.text = product.product!.productName!;
      marqueController.text = product.product!.brands!;
      quantiteController.text = product.product!.quantity!;
    });
  }

  _onAddButtonPressed() {
    var client = http.Client();
    var uri = Uri.parse('https://foodapi.bastianfabre.fr/api/produits');

    Map<String, dynamic> data = {
      'barcode': scannedCode,
      'categorie': categorieController.text,
      'nom': nomController.text,
      'marque': marqueController.text,
      'quantite': quantiteController.text,
      'unite': uniteController.text,
      'nombre': nombreController.text,
      'image': productImage,
    };

    String jsonString = jsonEncode({'data': data});

    client.post(uri, body: jsonString, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['API_TOKEN']!}',
    }).then(
      (response) {
        if (response.statusCode == 200) {
          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Produit ajouté avec succès'),
            ),
          );
        } else {
          return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Erreur lors de l\'ajout du produit : Code ${response.statusCode}'),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: categorieController,
                decoration: const InputDecoration(
                  labelText: 'Catégorie du produit',
                  icon: Icon(Icons.category),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom du produit',
                  icon: Icon(Icons.shopping_bag),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: marqueController,
                decoration: const InputDecoration(
                  labelText: 'Marque du produit',
                  icon: Icon(Icons.branding_watermark),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: quantiteController,
                decoration: const InputDecoration(
                  labelText: 'Quantité du produit',
                  icon: Icon(Icons.format_list_numbered),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: uniteController,
                decoration: const InputDecoration(
                  labelText: 'Unité du produit',
                  icon: Icon(Icons.storage),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de ce produit',
                  icon: Icon(Icons.filter_1),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _onScanButtonPressed();
                      },
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Scanner'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await _onAddButtonPressed();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Ajouter'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
