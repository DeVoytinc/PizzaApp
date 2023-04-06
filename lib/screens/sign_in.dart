import 'package:flutter/material.dart';
import 'package:flutter_application_1/UserModel.dart';
import 'package:flutter_application_1/screens/log_in.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DatabaseHandler/DbHelper.dart';
import '../HomePage.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with TickerProviderStateMixin{
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  Color prim = Color.fromARGB(255, 255, 138, 71);

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();

  var dbHelper;
  // signUp(){
  //   Ыекштп uid = 
  //   print('ok');
  // }

  @override
  void initState(){
    super.initState();
    dbHelper = DbHelper();
  }

  login() async{
    String uid = _conUserId.text;
    String password = _conPassword.text;

    if (uid.isEmpty){
      Toast.show('Введите логин', duration: Toast.lengthLong, gravity: Toast.bottom); 
    } else if (password.isEmpty){
      Toast.show('Введите пароль', duration: Toast.lengthLong, gravity: Toast.bottom); 
    } else {
      // ignore: non_constant_identifier_names
      await dbHelper.getLoginUser(uid, password).then((UserData) {

        if (UserData != null){

          setSP(UserData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
              context, 
              MaterialPageRoute(builder: (_) => HomePage()), 
              (Route<dynamic> route) => false);
          });
          
          
        } else {
          Toast.show('Пользователь не найден', duration: Toast.lengthLong, gravity: Toast.bottom);
        }

      }).catchError((error) {
        print(error);
        Toast.show('Ошибка при входе', duration: Toast.lengthLong, gravity: Toast.bottom);
      });
    }
  }


  Future setSP(UserModel user) async{
    final SharedPreferences sp = await _pref;

    sp.setString('user_id', user.userId);
    sp.setString('email', user.email);
    sp.setString('password', user.password);
  } 

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    //final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(color: prim, width: double.infinity,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('lib/images/upper.png', scale: 2,),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/images/pizza.png', scale: 2,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Image.asset('lib/images/pizzaimag.png',scale: 2,),
          ),
          

          Transform.translate(
            offset: Offset(120, 130),
            child: Container(
              width: 400,
              height: 400,
                child: Lottie.asset('lib/images/19705-chef.zip'),
            ),
          ),          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.asset('lib/images/bottom.png', fit: BoxFit.fitWidth,)),
                    Padding(
                      padding: const EdgeInsets.only(left: 70.0, top: 20),
                      child: Text(
                        'Вход',
                        style: GoogleFonts.balsamiqSans(
                          fontSize: 40,
                          color:  prim,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0, left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _conUserId,
                            decoration: InputDecoration(
                              hintText: 'Логин',
                              hintStyle: TextStyle(
                                color: prim,
                              ),
                              prefixIcon: Icon(Icons.person),
                              prefixIconColor: prim,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              //hintText: 'Enter a search term',
                            ),
                          ),
                          //Text('Почта'),
                          // SizedBox(height: 15,),
                          // TextField(
                          //   keyboardType: TextInputType.emailAddress,
                          //   decoration: InputDecoration(
                          //     hintText: 'Почта',
                          //     prefixIcon: Icon(Icons.email),
                          //     prefixIconColor: prim,
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(15)
                          //     ),
                          //     //hintText: 'Enter a search term',
                          //   ),
                          // ),
                          //Text('Пароль'),
                          
                          SizedBox(height: 20,),
                          TextField(
                            controller: _conPassword,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Пароль',
                              hintStyle: TextStyle(
                                color: prim,
                              ),
                              prefixIcon: Icon(Icons.password),
                              prefixIconColor: prim,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              //hintText: 'Enter a search term',
                            ),
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(
                            onPressed: (){
                              //SignUp();
                              login();
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: ((context) => HomePage())
                              //   ),
                              // );
                            }, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: prim,
                              minimumSize: Size(360,65),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                              //side: BorderSide(color: Colors.red, width: 5),
                            ),
                            child: Text(
                              'Вход',
                              style: GoogleFonts.balsamiqSans(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            )
                          ),
                          SizedBox(height: 20,),
                          Center(
                            child: TextButton(
                              onPressed: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) => Login())
                                  ),
                                );}, 
                              child: Text(
                                'Зарегистрироваться',
                                style: GoogleFonts.balsamiqSans(
                                  color: prim,
                                  fontSize: 20,
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                //Expanded(flex: isKeyboard ? 1 : 0,child: Container(color: Colors.white,))
              ],
            )
          ),
        ],
      ),
    );
  }
}