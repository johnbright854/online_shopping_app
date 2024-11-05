import 'package:flutter/material.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/screens/product_detail_page.dart';
import 'package:provider/provider.dart';

import '../components/star_rating.dart';
import '../model/products.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<CartModel>(
        builder: (BuildContext context, CartModel value, Widget? child) {
          // Group products by category
          final categoryGroups = <String, List<Products>>{};
          for (var product in value.wishItem) {
            categoryGroups.putIfAbsent(product.category ?? 'Uncategorized', () => []).add(product);
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categoryGroups.entries.map((entry) {
                final categoryName = entry.key;
                final products = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      // Horizontal List of Products
                      SizedBox(
                        height: 250, // Adjust the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final wishProduct = products[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 180,
                                child: GestureDetector(
                                  onTap: (){
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: (){
                                                    Provider.of<CartModel>(context, listen: false).toggleWishlist(wishProduct);
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Provider.of<CartModel>(context).inWishlist(wishProduct) ? Colors.red : Colors.grey[300],
                                                  )
                                              ),
                                            ],
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ProductDetailScreen(product: wishProduct, heroTag: 'shop_${wishProduct.id.toString()}',),
                                                  ),
                                                );
                                              },
                                              child: Hero(
                                                tag: wishProduct.id.toString(),
                                                child: Image.network(
                                                  wishProduct.image.toString(),
                                                  height: 90,
                                                  width: 90,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            wishProduct.title!.length > 20
                                                ? wishProduct.title!.substring(0, 15)
                                                : wishProduct.title.toString(),
                                            style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                                          ),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                StarRating(rating: wishProduct.rating!.rate as double, starSize: 15,),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 0),
                                                  child: Text('(${wishProduct.rating!.rate.toString()})'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
