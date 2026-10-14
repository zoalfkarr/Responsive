import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({
    super.key,
    this.isDrawer = false,
    this.selectedIndex = 2,
    this.onItemSelected,
  });

  final bool isDrawer;
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: const Text(
            'John Doe',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          accountEmail: const Text('john.doe@example.com'),
          currentAccountPicture: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&q=80&w=200',
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        ListTile(
          selected: selectedIndex == 0,
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            onItemSelected?.call(0);
            if (isDrawer) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: selectedIndex == 1,
          leading: const Icon(Icons.business_center_rounded),
          title: const Text('Orders'),
          onTap: () {
            onItemSelected?.call(1);
            if (isDrawer) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: selectedIndex == 2,
          leading: const Icon(Icons.inventory_2),
          title: const Text('Products'),
          onTap: () {
            onItemSelected?.call(2);
            if (isDrawer) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: selectedIndex == 3,
          leading: const Icon(Icons.people),
          title: const Text('Customers'),
          onTap: () {
            onItemSelected?.call(3);
            if (isDrawer) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: selectedIndex == 4,
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            onItemSelected?.call(4);
            if (isDrawer) Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
