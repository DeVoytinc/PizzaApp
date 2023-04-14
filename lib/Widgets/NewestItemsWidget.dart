import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pizza_model.dart';
import 'package:flutter_application_1/screens/shop_cart.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:toast/toast.dart';
import '../DatabaseHandler/fillpizzesbd.dart';

//import '../main.dart';

_addToOrderList(Pizza addedPissa) {
  if (orderList.contains(addedPissa)) {
    Toast.show('Такой товар уже есть в корзине',
        duration: Toast.lengthLong, gravity: Toast.bottom);
  } else {
    orderList.add(addedPissa);
  }
}

String searchedtext = '';

class NewestItemsWidget extends StatefulWidget {
  const NewestItemsWidget({super.key});

  @override
  State<NewestItemsWidget> createState() => _NewestItemsWidgetState();
}

class _NewestItemsWidgetState extends State<NewestItemsWidget> {
  var dbHelper;
  late FillPizzes fp;
  late List<Pizza> pizzes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fp = FillPizzes();
  }

  getPizzes() async {
    pizzes = await fp.getSortedMapList(searchedtext);
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return FutureBuilder(
      future: getPizzes(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Column(
              children: List.generate(
            pizzes.length,
            (index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Container(
                  width: 380,
                  height: 160,
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
                              child: Image.asset(
                                pizzes[index].imagePath,
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
                              Text(
                                pizzes[index].name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                pizzes[index].description,
                                style: TextStyle(
                                  fontSize: 16,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                              RatingBar.builder(
                                initialRating:
                                    pizzes[index].rating.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 18,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.red,
                                ),
                                onRatingUpdate: (index) {},
                              ),
                              Text(
                                pizzes[index].price.toString() + " руб",
                                style: TextStyle(
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Container()),
                              // Icon(Icons.favorite_border,
                              //   color: Colors.red,
                              //   size: 26,
                              // ),
                              IconButton(
                                icon: Icon(CupertinoIcons.cart),
                                color: Colors.red,
                                onPressed: () {
                                  _addToOrderList(pizzes[index]);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ));
        }
        else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
