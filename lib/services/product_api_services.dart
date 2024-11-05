import 'dart:convert';
import 'package:online_store/model/products.dart';
import 'package:http/http.dart' as http;

class ProductApiServices {
  String baseUrl = 'https://fakestoreapi.com/products';
  List<Products>listOfProducts = [];

  Future<List<Products>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        listOfProducts = body.map<Products>((e) {
          return Products(
              id: e['id'].toString(),
              title: e['title'],
              price: (e['price'] is int)
                  ? (e['price'] as int).toDouble()
                  : e['price'],
              description: e['description'],
              category: e['category'],
              image: e['image'],
              rating:Rating(rate: (e['rating']['rate']).toDouble(), count: (e['rating']['count'])),
          );
        }
        ).toList();
        return listOfProducts;
      } else {
        print('Please try again...');
      }
    } catch (e) {
      print('Error Occured $e');
    }

    return [];
  }

  Future<List<String?>> getCategories() async {
    if (listOfProducts.isEmpty) {
      await getProducts();
    }
    List<String> categories = listOfProducts
        .where((product) => product.category != null)
        .map((product) => product.category!)
        .toSet()
        .toList();
    print('Categories: $categories'); // Final categories list
    return categories;
  }


  }
