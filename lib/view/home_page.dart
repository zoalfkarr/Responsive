import 'package:flutter/material.dart';
import 'package:responsive/models/product.dart';

import '../Widget/select_content.dart';
import 'navigation_menu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Orders';
      case 2:
        return 'Products Inventory';
      case 3:
        return 'Customers';
      case 4:
        return 'Settings';
      default:
        return 'Products Inventory';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> product = Product.dummyProducts;
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        leading: isMobile
            ? Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              )
            : null,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getAppBarTitle(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Manage your catalog, prices, and stock levels.',
              style: TextStyle(fontSize: 12, color: Color(0xFFC0C0C0)),
            ),
            const SizedBox(height: 10),
          ],
        ),
        actions: [
          if (_selectedIndex == 2) ...[
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 2),
                  Text('Add new product'),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ],
        bottom: _selectedIndex == 2
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),

                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText:
                              'Search products by Name, ID, or Category...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
      drawer: isMobile
          ? Drawer(
              child: NavigationMenu(
                isDrawer: true,
                selectedIndex: _selectedIndex,
                onItemSelected: _onItemTapped,
              ),
            )
          : null,
      body: isMobile
          ? SelectedContent(
              selectedIndex: _selectedIndex,
              products: product,
              searchQuery: _searchQuery,
            )
          : Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: NavigationMenu(
                      isDrawer: false,
                      selectedIndex: _selectedIndex,
                      onItemSelected: _onItemTapped,
                    ),
                  ),
                ),
                Expanded(
                  child: SelectedContent(
                    selectedIndex: _selectedIndex,
                    products: product,
                    searchQuery: _searchQuery,
                  ),
                ),
              ],
            ),
    );
  }
}
