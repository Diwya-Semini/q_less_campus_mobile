/// Represents a single food product in the Q-Less Campus system.
/// This is used to pass structured information between
/// the Menu and Product Detail screens.
class FoodItem {
  final String name;
  final String price;
  final String img;
  final String type;

  // Constructor
  FoodItem({
    required this.name,
    required this.price,
    required this.img,
    required this.type,
  });
}
