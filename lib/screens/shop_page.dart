import 'package:flutter/material.dart';
import 'package:online_store/components/star_rating.dart';
import 'package:online_store/model/products.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/screens/product_detail_page.dart';
import 'package:online_store/services/product_api_services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Future<List<Products>>? listOfProducts;
  final ProductApiServices productApiServices = ProductApiServices();
  List<String?> categories = [];
  String? selectedCategory = '';

  @override
  void initState() {
    super.initState();
    listOfProducts = productApiServices.getProducts();
    loadCategories();
  }


  void loadCategories()async{
    categories = await productApiServices.getCategories();
    categories.add('All');
    setState(() {
      selectedCategory = categories.isNotEmpty ? categories.last : 'none';
    });
    print(categories);
  }

  @override
  Widget build(BuildContext context) {
    //final wishItems = Provider.of<CartModel>(context).wishItem;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: listOfProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor:  Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      elevation: 5,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          }
          List<Products> products = snapshot.data!;
          List<Products> filteredProducts = selectedCategory!.isEmpty || selectedCategory == null || selectedCategory == 'All'
              ? products
              : products.where((product)=>product.category == selectedCategory).toList();
          return Padding(
            padding: const EdgeInsets.only( left: 5, right: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
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
                      height: 50,
                      // width: 180,
                      // height: 40,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                            value: selectedCategory,
                            items: categories.map((String? category){
                              return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category!)
                              );
                            }).toList(),
                            onChanged: (String? newValue){
                              setState(() {
                                selectedCategory = newValue!;
                              });
                            }),
                      ),
                    ),
                  ],
                ),
                Expanded( // Wrap GridView in Expanded
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.60,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 0.0,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(product: product, heroTag: 'shop_${product.id.toString()}',),
                            ),
                          );
                        },
                        child: Hero(
                          tag: product.id.toString(),
                          child: Card(
                            color: Colors.white,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Center(
                                        child: Image.network(
                                          product.image.toString(),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: (){
                                        Provider.of<CartModel>(context, listen: false).toggleWishlist(product);
                                      },
                                      icon: Icon(
                                      Icons.favorite,
                                      color: Provider.of<CartModel>(context).inWishlist(product) ? Colors.red : Colors.grey[300],
                                    )
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    product.title!.length > 20
                                        ? product.title!.substring(0, 15)
                                        : product.title.toString(),
                                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StarRating(rating: product.rating!.rate as double, starSize: 15,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 0),
                                        child: Text('(${product.rating!.rate.toString()})'),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.purple,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20, left: 8, top: 2, bottom: 2),
                                        child: Text('Stock: ${product.rating!.count.toString()}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold
                                        ),),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text('\$${product.price.toString()}'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                      child: Provider.of<CartModel>(context).cartItems.contains(product) ?

                                        Container(
                                          margin: EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius: BorderRadius.all(Radius.circular(8))),
                                                height: 30,
                                                width: 30,
                                                child: IconButton(
                                                    onPressed: (){Provider.of<CartModel>(context, listen: false).removeFromCart(product);},
                                                    icon: Icon(Icons.remove,color: Colors.black,size: 15,),
                                                )
                                            ),
                                            Container(
                                                padding:EdgeInsets.symmetric(horizontal: 7),
                                                child: Text(Provider.of<CartModel>(context, listen: false).countProductOccurrences(product).toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: BorderRadius.all(Radius.circular(8))),
                                              height: 30,
                                                width: 30,

                                                child: IconButton(onPressed: (){Provider.of<CartModel>(context, listen: false).addToCart(product);},
                                                    icon: Icon(Icons.add,color: Colors.black, size: 15,)))
                                          ],
                                        ))
                                        : IconButton(
                                      onPressed: () {
                          Provider.of<CartModel>(context, listen: false).addToCart(product);
                          },
                          icon: Icon(Icons.shopping_bag),
                          )

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
              ],
            ),
          );
        },
      ),
    );
  }
}
