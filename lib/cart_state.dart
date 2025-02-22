class CartState {
  // Global cart list to hold products
  static final List<Map<String, String>> cartItems = [];

  // Method to add an item to the cart
  static void addToCart(Map<String, String> product) {
    cartItems.add(product);
  }

  // Method to remove an item from the cart
  static void removeFromCart(Map<String, String> product) {
    cartItems.remove(product);
  }

  // Method to clear the entire cart
  static void clearCart() {
    cartItems.clear();
  }

  // Method to calculate the subtotal
  static double calculateSubtotal() {
    double subtotal = 0.0;
    for (var item in cartItems) {
      double price = double.parse(item['price']!.replaceAll('\$', ''));
      subtotal += price;
    }
    return subtotal;
  }

  // Method to check if the cart is empty
  static bool isCartEmpty() {
    return cartItems.isEmpty;
  }
}
