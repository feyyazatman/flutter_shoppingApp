import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String imgUrl;
  final String title;
  final String price;
  const ProductCard(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.price})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Image.network(
          widget.imgUrl,
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
        Text(widget.title),
        Text(widget.price)
      ],
    ));
  }
}
