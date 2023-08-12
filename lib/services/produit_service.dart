import 'dart:convert';
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

  Future<http.Response> addProduit(Produit produit) async {
    var client = http.Client();
    var uri = Uri.parse('https://foodapi.bastianfabre.fr/api/produits');

    Map<String, dynamic> data = {
      'barcode': produit.barcode.toString(),
      'categorie': produit.categorie,
      'nom': produit.nom,
      'marque': produit.marque,
      'quantite': produit.quantite,
      'nombre': produit.nombre,
      'image': produit.image,
    };

    String jsonString = jsonEncode({'data': data});

    return await client.post(uri, body: jsonString, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['API_TOKEN']!}',
    });
  }
}
