import 'package:flutter/material.dart';
import 'package:online_store/components/bottom_nav_bar.dart';
import 'package:online_store/screens/cart_page.dart';
import 'package:online_store/screens/intro_page.dart';
import 'package:online_store/screens/shop_page.dart';
import 'package:online_store/screens/wish_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  bool _isEditable = false;
  int _selectedIndex = 0;

  final List<String> _titles = ["Shop", "Cart", "Wishlist"];

  void navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  final List<Widget> _pages = [
    const ShopPage(),
    CartPage(),
    Wishlist(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex],style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        automaticallyImplyLeading: false,
        // leading: Builder(builder: (context)=>IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {
        //     Scaffold.of(context).openDrawer();
        //   },
        // )),
        actions: [
          // Container(
          //   padding: EdgeInsets.all(10),
          // margin: EdgeInsets.symmetric(horizontal: 10),
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(25),
          //     boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey.withOpacity(0.5), // Shadow color
          //       spreadRadius: 2, // Spread of the shadow
          //       blurRadius: 5, // Blur radius
          //       offset: Offset(0, 3), // Offset in the x and y direction
          //     ),
          //   ],
          // ),
          // width: 200,
          // height: 40,
          // child: Row(
          //   children: [
          //     Expanded(
          //       child: TextField(
          //         showCursor: _isEditable,
          //         readOnly: !_isEditable,
          //           enableInteractiveSelection: false,
          //         decoration: InputDecoration(
          //             hintText: 'search',
          //             border: InputBorder.none
          //         ),
          //
          //           onTap: () {
          //             setState(() {
          //               _isEditable = true; // Enable cursor and editing
          //             }
          //             );
          //           },
          //           onEditingComplete: () {
          //             setState(() {
          //               _isEditable = false; // Hide cursor when done editing
          //             });
          //           }
          //       ),
          //     ),
          //     Icon(Icons.search_sharp)
          //   ],
          // ),
          // )
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroPage()) );
          }, icon: Icon(Icons.logout))
        ],
        
      ),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index)=>navigateBottomBar(index),
      ),
      // drawer: Drawer(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Column(
      //         children: [
      //           DrawerHeader(
      //               decoration: BoxDecoration(
      //                 border: Border(bottom: BorderSide.none),
      //               ),
      //               child: Image.asset('lib/images/adidas.png',color: Colors.white,)),
      //           SizedBox(height: 30),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 50),
      //             child: ListTile(
      //               leading: Icon(
      //                 Icons.home,color: Colors.white,
      //               ),
      //               title: Text('Home',style: TextStyle(color: Colors.white),),
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 50),
      //             child: ListTile(
      //               leading: Icon(
      //                 Icons.info,color: Colors.white,
      //               ),
      //               title: Text('About',style: TextStyle(color: Colors.white),),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
      //         child: ListTile(
      //           leading: Icon(
      //             Icons.logout,color: Colors.white,
      //           ),
      //           title: Text('Logout',style: TextStyle(color: Colors.white),),
      //         ),
      //       )
      //     ],
      //   ),
      //   backgroundColor: Colors.grey[900],
      // ),
      body: _pages[_selectedIndex],
    );
  }
}
