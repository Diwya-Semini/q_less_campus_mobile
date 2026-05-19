class Product {
  final int id;
  final String itemName;
  final String category;
  final double price;
  final String? imageUrl;
  final String? description;

  Product({
    required this.id,
    required this.itemName,
    required this.category,
    required this.price,
    this.imageUrl,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      // The ?? operator says: "If the left side is null, use the right side instead"
      id: json['id'] ?? 0,

      // Safely checks for 'item_name', falls back to 'name', then falls back to 'Unknown Item'
      itemName:
          json['item_name']?.toString() ??
          json['name']?.toString() ??
          'Unknown Item',

      category: json['category']?.toString() ?? 'Uncategorized',

      // tryParse safely attempts to convert the string to a double, falls back to 0.0 if it fails
      price: double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,

      // These are already allowed to be null, but we add .toString() just to be safe
      imageUrl: json['image_url']?.toString(),
      description: json['description']?.toString(),
    );
  }
}
