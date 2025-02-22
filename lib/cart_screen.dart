import 'package:flutter/material.dart';
import 'cart_state.dart';
import 'payment_screen.dart'; // Import the PaymentScreen

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: Colors.green,
      ),
      body: CartState.cartItems.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: CartState.cartItems.length,
              itemBuilder: (context, index) {
                final item = CartState.cartItems[index];
                return ListTile(
                  leading: Image.asset(item['image']!, width: 50),
                  title: Text(item['name']!),
                  subtitle: Text(
                      'Size: ${item['size']}, Color: ${item['color']}, Price: ${item['price']}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to PaymentScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(product: item),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
