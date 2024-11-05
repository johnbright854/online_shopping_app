import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;
  final int starSize;

  const StarRating({required this.rating,this.starCount = 5,required this.starSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index){
        final currentRating = index + 1;
        if(rating >= currentRating){
          return Icon(Icons.star, color: Colors.amber, size: starSize.toDouble());
        }else if(rating > index && rating < currentRating){
          return Icon(Icons.star_half,color: Colors.amber, size: starSize.toDouble());
        }else{
          return Icon(Icons.star_border_outlined,color: Colors.amber, size: starSize.toDouble());
        }
      }),
    );
  }
}
