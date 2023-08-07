import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController categorieController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController marqueController = TextEditingController();
  final TextEditingController quantiteController = TextEditingController();
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
      quantiteController.text =
          product.product!.quantity!.split(' ')[0].replaceAll(',', '.');
    });
  }

  _onAddButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      var client = http.Client();
      var uri = Uri.parse('https://foodapi.bastianfabre.fr/api/produits');

      Map<String, dynamic> data = {
        'barcode': scannedCode,
        'categorie': categorieController.text,
        'nom': nomController.text,
        'marque': marqueController.text,
        'quantite': quantiteController.text,
        'nombre': nombreController.text,
        'image': productImage,
      };

      String jsonString = jsonEncode({'data': data});

      await client.post(uri, body: jsonString, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['API_TOKEN']!}',
      }).then(
        (response) {
          if (response.statusCode == 200) {
            categorieController.clear();
            nomController.clear();
            marqueController.clear();
            quantiteController.clear();
            nombreController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                    title: "Produit ajouté",
                    message: "Le produit a bien été ajouté à la liste",
                    contentType: ContentType.success),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.fixed,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                    title: "Erreur lors de l'ajout du produit",
                    message:
                        "Le produit n'a pas été ajouté à la liste \nCode d'erreur ${response.statusCode}",
                    contentType: ContentType.failure),
              ),
            );
          }
        },
      );
    }
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
          child: Form(
            key: _formKey,
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer une catégorie';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nomController,
                  decoration: const InputDecoration(
                    labelText: 'Nom du produit',
                    icon: Icon(Icons.shopping_bag),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un nom de produit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: marqueController,
                  decoration: const InputDecoration(
                    labelText: 'Marque du produit',
                    icon: Icon(Icons.branding_watermark),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer une marque';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: quantiteController,
                  decoration: const InputDecoration(
                    labelText: 'Quantité du produit',
                    icon: Icon(Icons.format_list_numbered),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer une quantité';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de ce produit',
                    icon: Icon(Icons.filter_1),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un nombre';
                    }
                    return null;
                  },
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
      ),
    );
  }
}
