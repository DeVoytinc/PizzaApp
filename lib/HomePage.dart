import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/AppBarWidget.dart';
import '../Widgets/NewestItemsWidget.dart';
import '../Widgets/PopularItemsWidget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String userID = '';
  String email = '';
  String passwrd = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async{
    final SharedPreferences sp = await _pref;

    setState(() {
      userID = sp.getString('user_id')!;
      email = sp.getString('email')!;
      passwrd = sp.getString('password')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Drawer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Логин: $userID'),
              Text('Почта: $email'),
              Text('Пароль: $passwrd'),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (_) => SignIn()), 
                    (Route<dynamic> route) => false);
                
                },
                  
                child: Text(
                  'Выйти',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          AppBarWidget(),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10,
            horizontal: 15,
          ),
            child: Container(
              width:  double.infinity,
              height: 50,
              decoration: BoxDecoration(
               color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                   color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset (0, 3),
                  ),
                ]
              ),
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 10,),
                child: Row(children: [
                  const Icon(CupertinoIcons.search,
                  color: Colors.red,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15,),
                      child: TextFormField(
                      decoration: const InputDecoration(
                        hintText:  "Какую пиццу предпочитаете?",
                        border: InputBorder.none,
                      ),
                      ) ,
                    ),
                  ),
                  //Icon(Icons.filter_list),
                ],
                ),
              ),

            ),
          ),

          // Популярная пицца
          const Padding(padding: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            "Популярное",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          ),

          // Популярное Items Widget
          PopularItemsWidget(),

          // Новинки

          const Padding(padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Новинки",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Новинки Items Widget

          NewestItemsWidget(),



        ],
      ),
    );
  }
}
