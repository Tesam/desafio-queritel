class Product {
  final String category;
  final String brand;
  final String title;
  final String weight;
  // ignore: non_constant_identifier_names
  final String weight_label;
  // ignore: non_constant_identifier_names
  final String pic_url;
  // ignore: non_constant_identifier_names
  final String lider_price;

  Product({
    this.category,
    this.brand,
    this.title,
    this.weight,
    // ignore: non_constant_identifier_names
    this.weight_label,
    // ignore: non_constant_identifier_names
    this.pic_url,
    // ignore: non_constant_identifier_names
    this.lider_price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      category: json['category'],
      brand: json['brand'],
      title: json['title'],
      weight: json['weight'],
      weight_label: json['weight_label'],
      pic_url: json['pic_url'],
      lider_price: json['lider_price'],
    );
  }
}
