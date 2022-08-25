class CartItem {
  final int id;
  final String name;
  double price;

  CartItem({required this.id, required this.name, required this.price,});
}

class BilItem extends CartItem {
  BilItem({required super.id, required super.name, required super.price, required this.quantity});
  int quantity;

  factory BilItem.fromCartItem(CartItem item) {
    return BilItem(id: item.id, name: item.name, price: item.price, quantity: 1);
  }

}