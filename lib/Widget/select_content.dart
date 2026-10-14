import 'package:flutter/material.dart';

import '../models/product.dart';
import '../view/Grid_view.dart';

class SelectedContent extends StatelessWidget {
  const SelectedContent({
    super.key,
    required this.selectedIndex,
    required this.products,
    this.searchQuery = '',
  });

  final int selectedIndex;
  final List<Product> products;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      if (searchQuery.isEmpty) return true;
      return product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.discrption.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    switch (selectedIndex) {
      case 0:
        return const Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        );
      case 1:
        return const Center(
          child: Text(
            'Orders',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        );
      case 2:
        return GridViewProduct(products: filteredProducts);
      case 3:
        return const Center(
          child: Text(
            'Customers',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        );
      case 4:
        return const Center(
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        );
      default:
        return GridViewProduct(products: filteredProducts);
    }
  }
}
