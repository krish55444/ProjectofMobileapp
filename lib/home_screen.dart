import 'package:flutter/material.dart';
import 'product_detailscreen.dart'; // Import Product Details Screen

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Sample shoe data
  final List<Map<String, String>> _shoes = [
    {'image': 'assets/F1.jpeg.jpg', 'name': 'Running Shoes', 'price': '\$100'},
    {'image': 'assets/F2.jpeg.jpg', 'name': 'Casual Shoes', 'price': '\$80'},
    {'image': 'assets/F3.jpeg.jpg', 'name': 'Formal Shoes', 'price': '\$120'},
    {'image': 'assets/F2.jpeg.jpg', 'name': 'Sneakers', 'price': '\$90'},
    {'image': 'assets/F1.jpeg.jpg', 'name': 'Boots', 'price': '\$150'},
  ];

  // Placeholder content for other tabs
  final List<Widget> _pages = [
    Center(child: Text('Home Page Content')), // Home tab is dynamic
    Center(child: Text('Profile Page')),      // Profile placeholder
    Center(child: Text('My Cart Page')),      // My Cart placeholder
    Center(child: Text('Details Page')),      // Details placeholder
    Center(child: Text('Settings Page')),     // Settings placeholder
  ];

  // Handle navigation bar taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? TextField(
                decoration: InputDecoration(
                  hintText: 'Search shoes...',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                ),
              )
            : Text('App Title'),
        backgroundColor: Colors.green,
      ),
      body: _selectedIndex == 0
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: _shoes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to Product Details Screen with data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            product: _shoes[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _shoes[index]['image']!,
                            height: 80,
                          ),
                          SizedBox(height: 10),
                          Text(
                            _shoes[index]['name']!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            _shoes[index]['price']!,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : _pages[_selectedIndex], // Show placeholder for other tabs
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
