import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../pizza_model.dart';


List<Pizza> orderList = [];
int subsum = 0;
int sum = 0;
const int sale = 10;
int count = 0;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  add(int index){
    setState(() {
      orderList[index].count++;
      count++;
      subsum += orderList[index].price;
    });
  }

  minus(int index){
    setState(() {
      if(orderList[index].count == 1){
        count--;
        subsum -= orderList[index].price;
        orderList.removeAt(index);
      }
      else{
        orderList[index].count--;
        count--;
        subsum -= orderList[index].price;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    
    for (var i = 0; i < orderList.length; i++) {
      count += orderList[i].count;
      subsum += orderList[i].price *  orderList[i].count;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    count = 0;
      subsum = 0;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Цена со скидкой: ',
                style: TextStyle(
                  fontSize: 17,
                ),
                ),
              Text(
                '${subsum * 0.90}',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Expanded(child: Container()),
              ElevatedButton(
                onPressed: (){}, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: Size(120, 100),
                  //minimumSize: Size(60,300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                  //side: BorderSide(color: Colors.red, width: 5),
                            ),
                child: Container(
                  child: Text(
                    'Купить',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(),
      body: ListView(
        
        //child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 0, left: 20),
              child: Text(
                "Корзина",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              child: Column(
                  children: 
                    List.generate(orderList.length, (index) {
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
                                    child: Image.asset(orderList[index].imagePath,
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
                                    Text(orderList[index].name,
                                      style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                            
                                    ),
                                    ),
                                    Text(orderList[index].description,
                                      style: TextStyle(
                                        fontSize: 16,
                                        //fontWeight: FontWeight.bold,
                            
                                      ),
                                    ),
                                    
                                    RatingBar.builder(
                                      initialRating: orderList[index].rating,
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
                                    Text(orderList[index].price.toString()+" руб", style: TextStyle(
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
                              flex: 4,
                              child: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    IconButton(
                                      icon: Icon(Icons.add,
                                        color: Colors.white,
                                        size: 26,
                                      ), 
                                      onPressed: () { add(index); },
                                    ),
                                    Text(
                                      orderList[index].count.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.remove,
                                        color: Colors.white,
                                        size: 26,
                                      ), 
                                      onPressed: () { minus(index); },
                                    ),
                                    SizedBox()
                                  ],),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  )
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        child: Row(
                          children: [
                            Text('Количество: '),
                            Expanded(child: Container()),
                            Text(count.toString())
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        child: Divider(),
                      ),
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        child: Row(
                          children: [
                            Text('Цена: '),
                            Expanded(child: Container()),
                            Text(subsum.toString())
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        child: Row(
                          children: [
                            Text('Скидка: '),
                            Expanded(child: Container()),
                            Text(sale.toString() + '%')
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
          ],
        //),
      ),
    );
  }
}