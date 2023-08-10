import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:food_inventory/models/produit.dart';

class ProduitService {
  Future<List<Produit>> getProducts() async {
    var produitList = <Produit>[];
    var client = http.Client();
    var uri = Uri.parse('https://foodapi.bastianfabre.fr/api/produits');
    await client.get(uri, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['API_TOKEN']!}',
    }).then(
      (response) {
        if (response.statusCode == 200) {
          var produits = jsonDecode(response.body)['data'];
          for (var produit in produits) {
            var produitParse = produit['attributes'];
            produitParse.remove('updatedAt');
            produitParse.remove('createdAt');
            produitParse.remove('deletedAt');
            produitParse.remove('locale');

            produitList.add(Produit.fromJson(produitParse));
          }
        }
      },
    );
    return produitList;
  }

  Future<http.Response> addProduit(
      BuildContext context,
      String scannedCode,
      String categorie,
      String nom,
      String marque,
      String quantite,
      String nombre,
      String productImage) async {
    var client = http.Client();
    var uri = Uri.parse('https://foodapi.bastianfabre.fr/api/produits');

    Map<String, dynamic> data = {
      'barcode': scannedCode,
      'categorie': categorie,
      'nom': nom,
      'marque': marque,
      'quantite': quantite,
      'nombre': nombre,
      'image': productImage,
    };

    String jsonString = jsonEncode({'data': data});

    return client.post(uri, body: jsonString, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['API_TOKEN']!}',
    });
  }
}
