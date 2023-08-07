class Produit {
  Produit(
      {required this.barcode,
      this.categorie,
      this.nom,
      this.marque,
      required this.quantite,
      required this.unite,
      required this.nombre,
      this.image});

  BigInt barcode;
  String? categorie;
  String? nom;
  String? marque;
  double quantite;
  String unite;
  int nombre;
  String? image;

  factory Produit.fromJson(Map<String, dynamic> json) => Produit(
        barcode: BigInt.parse(json["barcode"]),
        categorie: json["categorie"],
        nom: json["nom"],
        marque: json["marque"],
        quantite: json["quantite"],
        unite: json["unite"],
        nombre: json["nombre"],
        image: json["image"],
      );
}
