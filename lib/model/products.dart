class Products{
  String? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;


  int quantity = 1;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating
  });

  Products copyWith({int? quantity}) {
    return Products(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
    )..quantity = quantity ?? this.quantity;
  }


  @override
  String toString() {
    return 'Products(id: $id, title: $title, price: $price, category: $category)';
  }

  // Override equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Products && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}



class Rating{
  double? rate;
  int? count;

  Rating({
    required this.rate,
    required this.count
});


}


