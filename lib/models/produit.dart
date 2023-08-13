class Produit {
  Produit(
      {required this.barcode,
      this.categorie,
      this.nom,
      this.marque,
      required this.quantite,
      this.image});

  BigInt barcode;
  String? categorie;
  String? nom;
  String? marque;
  String? quantite;
  String? image;

  factory Produit.fromJson(Map<String, dynamic> json) => Produit(
        barcode: BigInt.parse(json["barcode"]),
        categorie: json["categorie"],
        nom: json["nom"],
        marque: json["marque"],
        quantite: json["quantite"],
        image: json["image"],
      );
}
