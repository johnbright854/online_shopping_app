import 'package:flutter/material.dart';
import 'package:online_store/screens/shop_page.dart';
import 'package:online_store/screens/wish_page.dart';
import 'package:provider/provider.dart';
import '../components/star_rating.dart';
import '../model/products.dart';
import '../provider/product_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Products product;
  final String? heroTag;

  const ProductDetailScreen({super.key, required this.product, required this.heroTag});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey[200],),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 2, // Spread of the shadow
                  blurRadius: 5, // Blur radius
                  offset: Offset(0, 3), // Offset in the x and y direction
                        ),
                      ],
                    ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(color: Colors.blue,),
                                child: Text('${widget.product.category}',style:TextStyle(fontSize: 16,color:Colors.white))),
                          ),
                          IconButton(
                              onPressed: (){
                                Provider.of<CartModel>(context, listen: false).toggleWishlist(widget.product);
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: Provider.of<CartModel>(context).inWishlist(widget.product) ? Colors.red : Colors.grey[300],
                              )
                          ),
                        ],
                      ),
                      Hero(
                        tag: widget.heroTag!, // Same tag as in ShopPage
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Image.network(
                            widget.product.image.toString(),
                            height: 250,
                            width: 350,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(child: Text(widget.product.title ?? '',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Price: \$${widget.product.price.toString()}',style: TextStyle(color:Colors.green, fontWeight: FontWeight.bold, fontSize: 15),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StarRating(rating: widget.product.rating!.rate as double, starSize: 20,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0),
                                  child: Text('(${widget.product.rating!.rate.toString()})'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Total Stock (${widget.product.rating!.count.toString()})', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold
                                            ),),
                          )

                        ],
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(widget.product.description ?? '', style: TextStyle(fontSize: 16),),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Provider.of<CartModel>(context).cartItems.contains(widget.product) ?
        
                Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.all(Radius.circular(8))),
                                height: 50,
                                width: 50,
                                child: IconButton(
                                  onPressed: (){Provider.of<CartModel>(context, listen: false).removeFromCart(widget.product);},
                                  icon: Icon(Icons.remove,color: Colors.black,size: 20,),
                                )
        
                            ),
                            Container(
                                padding:EdgeInsets.symmetric(horizontal: 10),
                                child: Text(Provider.of<CartModel>(context, listen: false).countProductOccurrences(widget.product).toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.all(Radius.circular(8))),
                                height: 50,
                                width: 50,
        
                                child: IconButton(onPressed: (){Provider.of<CartModel>(context, listen: false).addToCart(widget.product);},
                                    icon: Icon(Icons.add,color: Colors.black, size: 20,)))
                          ],
                        ),
                        SizedBox(height: 20,)
                      ],
                    ))
                    : GestureDetector(
                      onTap: () {
                        Provider.of<CartModel>(context, listen: false).addToCart(
                            widget.product);
                      },
                child: Column(
                  children: [
                    Container(
            margin: EdgeInsets.symmetric(horizontal: 90),
            padding: EdgeInsets.all(17),
                    decoration: BoxDecoration(
            color: Colors.purple,
              borderRadius: BorderRadius.circular(15),
              //border: Border.all(width: 1.0, color: Colors.grey)
            ),
                    child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Add to Cart', style: TextStyle(fontSize: 20, color: Colors.grey[300]),),
              SizedBox(width: 5,),
              Icon(Icons.shopping_bag,color: Colors.grey[300]),
              ],
              ),
        
            ],
                    ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
                )
                ),
        
                ],
                ),
                ),
            ),
            ),
      ),

    );
    }
  }

