class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? salePercentage;
  String? photoLink;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.salePercentage,
      this.photoLink});

  factory ProductModel.fromJson(Map<String, dynamic> obj) {
    return ProductModel(
      id: obj['id'],
      name: obj['name'],
      description: obj['description'],
      price: obj['price'],
      salePercentage: obj['salePercentage'],
      photoLink: obj['photoLink'],
    );
  }
}
