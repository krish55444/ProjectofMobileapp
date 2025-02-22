import 'package:flutter/material.dart';
import 'cart_state.dart'; // Import CartState for managing the cart

class PaymentScreen extends StatefulWidget {
  final Map<String, String> product;

  PaymentScreen({required this.product});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Parse product price
    double price = double.tryParse(widget.product['price']!.replaceAll('\$', '')) ?? 0.0;
    double taxRate = 0.1; // 10% tax
    double shippingFee = 5.0;

    double taxAmount = price * taxRate;
    double totalAmount = price + taxAmount + shippingFee;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Details
              Center(
                child: Image.asset(
                  widget.product['image'] ?? 'assets/default.png',
                  height: 150,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.product['name'] ?? 'Unknown Product',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                'Size: ${widget.product['size'] ?? 'N/A'}, Color: ${widget.product['color'] ?? 'N/A'}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Divider(),

              // Payment Summary
              Text('Payment Summary:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Subtotal:', style: TextStyle(fontSize: 16)),
                Text('\$${price.toStringAsFixed(2)}'),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Tax (10%):', style: TextStyle(fontSize: 16)),
                Text('\$${taxAmount.toStringAsFixed(2)}'),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Shipping Fee:', style: TextStyle(fontSize: 16)),
                Text('\$${shippingFee.toStringAsFixed(2)}'),
              ]),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ]),
              SizedBox(height: 20),

              // Delivery Address Form
              Text('Delivery Address:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Full Name'),
                      validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
                    ),
                    TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(labelText: 'City'),
                      validator: (value) => value!.isEmpty ? 'Please enter your city' : null,
                    ),
                    TextFormField(
                      controller: _postalController,
                      decoration: InputDecoration(labelText: 'Postal Code'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Please enter your postal code' : null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Proceed to Payment Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Remove product from the cart
                      CartState.removeFromCart(widget.product);

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Payment Successful!'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Return to Home Page or Cart Screen
                      Navigator.popUntil(context, ModalRoute.withName('/cart'));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all the details')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'Proceed to Payment',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
