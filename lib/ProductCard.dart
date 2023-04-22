import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:math';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  String name;
  String imageSource;
  int price;
  double rating;
  bool isNew;

  ProductCard({
    Key? key,
    required this.name,
    required this.imageSource,
    required this.price,
    required this.rating,
    required this.isNew
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ProductCard> createState() => _ProductCardState(
    name: name,
    imageSource: imageSource,
    price: price,
    rating: rating,
    isNew: isNew
  );
}

class _ProductCardState extends State<ProductCard> {
  String name;
  String imageSource;
  int price;
  double rating;
  bool isNew;
  Color? prominentColor;

  _ProductCardState({
      required this.name,
      required this.imageSource,
      required this.price,
      required this.rating,
      required this.isNew
  }) {_updatePalette();}

  _updatePalette() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      AssetImage(imageSource),
      size: const Size(200, 200),
    );

    setState(() {
      prominentColor = generator.vibrantColor?.color ?? generator.mutedColor?.color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      color: Colors.black87,
      sigma: 1,
      offset: const Offset(0, 7),

      /* Card Body */
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFDFDFDF),
        ),

        /* Top */
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: isNew,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Text(
                      'New',
                      style: TextStyle(
                        color: Color(0xFFDFDFDF),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Icon(
                  [Icons.favorite, Icons.favorite_border][Random().nextInt(2)],
                  size: 30,
                  color: Colors.teal,
                )
              ],
            ),

            /* Image */
            InkWell(
              onTap: (){},
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      top: 45,
                      child: Container(
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient:  LinearGradient(
                            colors: [
                              prominentColor ?? Colors.teal,
                              const Color(0xFFD7D7D7)
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                          color: prominentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    ),
                    SimpleShadow(
                        opacity: 0.6,
                        offset: const Offset(0, 7),
                        sigma: 4.5,
                        child: Image.asset(imageSource)          // Default: 2
                    ),
                  ]
                )
              ),
            ),

            /* Product Info */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF515151)
                  ),
                ),
                Text(
                  '\$$price',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1A1A1A)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 21,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.teal.shade300,
                      ),
                      onRatingUpdate: (rating) {}
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: const Icon(
                          Icons.shopping_cart,
                          size: 21,
                          color: Color(0xFFDFDFDF),
                        ),
                      ),
                    )
                  ],
                )
              ]
            )
          ],
        ),
      ),
    );
  }
}