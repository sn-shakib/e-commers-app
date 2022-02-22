import 'package:flutter/material.dart';
import 'package:full_app/store_page/cart_page.dart';
import 'package:full_app/store_page/home_page.dart';
import 'package:full_app/store_page/profile_page.dart';
import 'package:full_app/store_page/wishlist_page.dart';
import 'package:google_fonts/google_fonts.dart';
class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List pages=[const HomaePage(), const Wishlist(), const CartPage(), const ProfilePage()];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.black87,
        backgroundColor: Colors.tealAccent,
        type: BottomNavigationBarType.fixed,
        iconSize: 25 ,
        currentIndex: index,
        onTap: (value){
          setState(() {

          });
          index=value;
        },
        selectedLabelStyle:   GoogleFonts.andada(color: Colors.red),
         items:   [
        BottomNavigationBarItem(icon:  Icon(Icons.home),label: 'Home',),
          BottomNavigationBarItem(icon:  Icon(Icons.favorite),label: 'Wishlist',),
          BottomNavigationBarItem(icon:  Icon(Icons.shopping_cart),label: 'Cart'),
          BottomNavigationBarItem(icon:  Icon(Icons.person),label: 'profile'),
      ],),
    );
  }
}
