import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/bottom_nav/bottom_nav_cubit.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    CartScreen(),
    ProfileScreen(userId: 1),
  ];

  static const List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            body: _screens[selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              items: _navItems,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey[600]
                  : Colors.grey[400],
              onTap: (index) {
                context.read<BottomNavCubit>().updateIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.grey[900],
              elevation: 8,
            ),
          );
        },
      ),
    );
  }
}
