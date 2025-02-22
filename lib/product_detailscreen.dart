import 'package:flutter/material.dart';
import 'cart_state.dart'; // Import global cart state

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, String> product; // Product data passed from HomePage

  ProductDetailsScreen({required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedSize; // For storing the selected size
  String? _selectedColor; // For storing the selected color
  int _selectedIndex = 0; // Index for bottom navigation

  // Handle bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the appropriate screen
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/cart'); // Navigate to Cart Screen
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/settings'); // Example: Navigate to settings
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name']!), // Product name as title
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: Image.asset(
                  widget.product['image']!,
                  height: 200,
                ),
              ),
              SizedBox(height: 20),

              // Product Name
              Text(
                widget.product['name']!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Brand Name
              Text(
                'Brand: Nike', // Replace with dynamic data if needed
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 10),

              // Product Price
              Text(
                widget.product['price']!,
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 20),

              // Product Specifications
              Text(
                'Specifications:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '- Lightweight and durable\n'
                '- Breathable mesh material\n'
                '- Non-slip rubber sole\n'
                '- Available in multiple colors',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),

              // Size Selection
              Text(
                'Select Size:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: ['S', 'M', 'L', 'XL'].map((size) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSize = size; // Update selected size
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: _selectedSize == size ? Colors.green : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        size,
                        style: TextStyle(
                          color: _selectedSize == size ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Color Selection
              Text(
                'Select Color:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  {'color': Colors.red, 'name': 'Red'},
                  {'color': Colors.blue, 'name': 'Blue'},
                  {'color': Colors.green, 'name': 'Green'},
                ].map((colorOption) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = colorOption['name'] as String; // Update selected color
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorOption['color'] as Color,
                        border: Border.all(
                          color: _selectedColor == colorOption['name'] ? Colors.black : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Add to Cart Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedSize == null || _selectedColor == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a size and color')),
                      );
                      return;
                    }
                    // Add to global cart state
                    CartState.cartItems.add({
                      'name': widget.product['name']!,
                      'image': widget.product['image']!,
                      'price': widget.product['price']!,
                      'size': _selectedSize!,
                      'color': _selectedColor!,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to Cart!')),
                    );
                  },
                  child: Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),   
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
