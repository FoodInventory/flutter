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
  int quantite;
  String unite;
  int nombre;
  String? image;
}
