import 'package:flutter/material.dart';

import '../pizza_model.dart';

class PopularItemsWidget extends StatelessWidget{

  final List<Pizza> poppizzes = [
    Pizza(
      name: 'Маргарита', 
      description: 'пицца с томатами', 
      imagePath: 'lib/images/pizza1.png', 
      price: 500, 
      rating: 5
    ),
    Pizza(
      name: 'Сицилийская', 
      description: 'Итальянская', 
      imagePath: 'lib/images/pizza22.png', 
      price: 30, 
      rating: 0.1
    ),
    Pizza(
      name: 'Бургер', 
      description: 'с ветчиной', 
      imagePath: 'lib/images/burger.png', 
      price: 680, 
      rating: 4
    ),
    Pizza(
      name: 'Греческая', 
      description: 'оливки, помидор', 
      imagePath: 'lib/images/pizza3.png', 
      price: 390, 
      rating: 3
    ),
    Pizza(
      name: 'Нагетсы', 
      description: 'куринные', 
      imagePath: 'lib/images/pizza4.png', 
      price: 420, 
      rating: 4
    ),
    Pizza(
      name: 'Чикагская', 
      description: 'начинка на выбор', 
      imagePath: 'lib/images/pizza5.png', 
      price: 470, 
      rating: 5
    ),
     Pizza(
      name: 'Бурито', 
      description: 'курица', 
      imagePath: 'lib/images/burito.png', 
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
  Widget build( BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:
      Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: 
          List.generate(poppizzes.length, (index) {
            //for(int i=0; i<8; i++)
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 170,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ]
                ),
              child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,right: 10, left: 10,),
                      child: Container(
                        child: Image.asset(
                          poppizzes[index].imagePath,
                          height: 130,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(poppizzes[index].name,
                      style: TextStyle(
                      fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(poppizzes[index].description ,
                      style: TextStyle(
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${poppizzes[index].price} руб", style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,

                        ),),
                        Icon(Icons.favorite_border,
                        color: Colors.red,
                          size: 26,
                        ),

                      ],
                    ),
                  ],
                ),
              ) ,
            ),
          );
          },
        ),
      ),
      ),
    );
  }
}