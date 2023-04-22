import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce/ProductCard.dart';
import 'package:badges/badges.dart' as badges;

void main() {
  runApp(const NikeEcommerce());
}

class NikeEcommerce extends StatelessWidget {
  const NikeEcommerce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProductCard> products = [];
    for (int i = 1; i <= 10; i++) {
      Random random = Random();
      products.add(ProductCard(
        name: 'Nike Sneakers $i',
        imageSource: 'assets/Sneakers/$i.png',
        price: (7 + random.nextInt(3)) * 100,
        rating: 3.0 + random.nextInt(3),
        isNew: [true, false][random.nextInt(2)],
      ));
    }
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF202020),
          appBar: AppBar(
            leading: const Icon(Icons.menu),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nike ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.teal.shade300
                  )
                ),
                const Text(
                  'Store',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  )
                ),
              ],
            ),
            actions: const [Icon(Icons.more_vert)],
            backgroundColor: const Color(0xFF313131)
          ),
          body: ListView(
            children: [
              Column (
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    padding:  const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFDFDF),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '  Search'
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF313131)
                    ),
                    child: GridView.count(
                      physics: ScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 0.64,
                      shrinkWrap: true,
                      children: products
                    )
                  )
                ]
              ),
            ]
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.teal,
            child: badges.Badge(
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.teal.shade100
              ),
              badgeContent: const Text(
                '4',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              child: const Icon(
                Icons.shopping_bag,
                size: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
