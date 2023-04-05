import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pizza_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../main.dart';

class NewestItemsWidget extends StatelessWidget{

  List<Pizza> newestpizzes = [
    Pizza(
      name: 'Сибадишная', 
      description: 'Дорогие каперсы, анчоусы, сыр', 
      imagePath: 'lib/images/pizza55.png', 
      price: 500, 
      rating: 5
    ),
    Pizza(
      name: 'Политехская', 
      description: 'один хлеб', 
      imagePath: 'lib/images/pizza33.png', 
      price: 30, 
      rating: 0.1
    ),
    Pizza(
      name: 'Гавайская', 
      description: 'ветчина, мацарелла и томатный соус', 
      imagePath: 'lib/images/pizza44.png', 
      price: 680, 
      rating: 4
    ),
    Pizza(
      name: 'Тирольская', 
      description: 'ветчина, оливки, пармезан, томаты', 
      imagePath: 'lib/images/pizza66.png', 
      price: 390, 
      rating: 3
    ),
    Pizza(
      name: 'Чикагская', 
      description: 'моцарелла, пармезан', 
      imagePath: 'lib/images/pizza77.png', 
      price: 420, 
      rating: 4
    ),
    Pizza(
      name: 'Капричоза', 
      description: 'сочитание грибов и томатов', 
      imagePath: 'lib/images/pizza88.png', 
      price: 470, 
      rating: 5
    ),
     Pizza(
      name: 'Сырная', 
      description: 'очень много сыра, прям очень', 
      imagePath: 'lib/images/pizza99.png', 
      price: 360, 
      rating: 4
    ),
    Pizza(
      name: 'Сибадишная', 
      description: 'из годной муки', 
      imagePath: 'lib/images/pizza112.png', 
      price: 990, 
      rating: 5
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: 
        List.generate(newestpizzes.length, (index) {
          return Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10,),
            child: Container(
            width: 380, height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow:[ 
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0,3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(newestpizzes[index].imagePath,
                          height: 120,
                          width: 150,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: Container(
                    width: 173,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(newestpizzes[index].name,
                          style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                
                        ),
                        ),
                        Text(newestpizzes[index].description,
                          style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                
                          ),
                        ),
                        
                        RatingBar.builder(
                          initialRating: newestpizzes[index].rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 18,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder:
                              (context, _) => Icon(
                                Icons.star, color:
                          Colors.red,),
                          onRatingUpdate: (index){},
                        ),
                        Text(newestpizzes[index].price.toString()+" руб", style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 10,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.favorite_border,
                          color: Colors.red,
                          size: 26,
                        ),
                        Icon(
                          CupertinoIcons.cart,
                          color: Colors.red,
                          size: 26,
                        ),
                      ],),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      )
    );
  }
}