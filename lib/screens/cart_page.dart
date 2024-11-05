import 'package:flutter/material.dart';
import 'package:online_store/provider/product_provider.dart'; // Ensure you have the right path for CartModel
import 'package:online_store/screens/product_detail_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.totalItems,
                  itemBuilder: (context, index) {
                    final product = cart.cartItems[index];
                    return Card(
                      color: Colors.white,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(product: product, heroTag: 'shop_${product.id.toString()}',),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Hero(
                                tag: product.id.toString(),
                                child: Image.network(
                                  product.image!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '\$${product.price}',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(  color: Colors.grey[300],borderRadius: BorderRadius.circular(8)),
                                    child: IconButton(
                                      onPressed: () {
                                        Provider.of<CartModel>(context, listen: false).removeFromCart(product);
                                      },
                                      icon: Icon(Icons.remove, color: Colors.black),
                                      iconSize: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      cart.countProductOccurrences(product).toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(  color: Colors.grey[300],borderRadius: BorderRadius.circular(8)),
                                    child: IconButton(

                                      onPressed: () {
                                        Provider.of<CartModel>(context, listen: false).addToCart(product);
                                      },
                                      icon: Icon(Icons.add, color: Colors.black),
                                      iconSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Total Price at the Bottom
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20, color: Colors.grey[200], fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${cart.totalPrice}',
                      style: TextStyle(fontSize: 20, color: Colors.grey[200], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
