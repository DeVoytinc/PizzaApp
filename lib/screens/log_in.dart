import 'package:flutter/material.dart';
import 'package:flutter_application_1/DatabaseHandler/DbHelper.dart';
import 'package:flutter_application_1/UserModel.dart';
import 'package:flutter_application_1/screens/sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
// 
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>{

  Color prim = Color.fromARGB(255, 255, 138, 71);

  final _cUserId = TextEditingController();
  final _cEmail = TextEditingController();
  final _cPassword = TextEditingController();
  final _cApplyPassword = TextEditingController();
  var dbHelper;

@override
  void initState(){
    super.initState();
    dbHelper = DbHelper();
  }

  signUp(_context) async{
    String uid = _cUserId.text;
    String email = _cEmail.text;
    String password = _cPassword.text;
    String cpassword = _cApplyPassword.text;

    if (uid.isEmpty){
      Toast.show('Введите логин', duration: Toast.lengthLong, gravity: Toast.bottom); 
    } else if (email.isEmpty){
      Toast.show('Введите почту', duration: Toast.lengthLong, gravity: Toast.bottom); 
    }else if (password.isEmpty){
      Toast.show('Введите пароль', duration: Toast.lengthLong, gravity: Toast.bottom); 
    }else if (cpassword.isEmpty){
      Toast.show('Подтвердите пароль', duration: Toast.lengthLong, gravity: Toast.bottom); 
    }

    if (password != cpassword){
      Toast.show('Пароли не совпадают', duration: Toast.lengthLong, gravity: Toast.bottom);
    }
    else{
      UserModel uModel = UserModel(uid, email, password);
      await dbHelper.saveData(uModel).then((userData) {
        Toast.show('Успешно сохранено', duration: Toast.lengthLong, gravity: Toast.bottom);

        Navigator.push(
            context, 
            MaterialPageRoute(builder: (_) => SignIn()));

      });//.catchError((error){
        //print(error);
        //Toast.show('Ошибка при сохранении данных', duration: Toast.lengthLong, gravity: Toast.bottom);
      //}
      //);

    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 50,child: Container(color: prim,)),
              Expanded(flex: 40, child: Container()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('lib/images/leftpizza.png',scale: 2,),
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
          

          Transform.translate(
            offset: Offset(120, 60),
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
                      padding: EdgeInsets.only(bottom: 100),
                      width: double.infinity,
                      child: Image.asset('lib/images/bottom.png', fit: BoxFit.fitWidth,)),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 50),
                      child: Text(
                        'Регистрация',
                        style: GoogleFonts.balsamiqSans(
                          fontSize: 30,
                          color:  prim,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 110.0, left: 30, right: 30),
                      child: Column(
                        children: [
                          TextField(
                            controller: _cUserId,
                            keyboardType: TextInputType.emailAddress,
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
                          SizedBox(height: 20,),
                          TextField(
                            controller: _cEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Почта',
                              hintStyle: TextStyle(
                                color: prim,
                              ),
                              prefixIcon: Icon(Icons.email),
                              prefixIconColor: prim,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              //hintText: 'Enter a search term',
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextField(
                            controller: _cPassword,
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
                          TextField(
                            controller: _cApplyPassword,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            //obscuringCharacter: "*",
                            decoration: InputDecoration(
                              hintText: 'Подтверждение пароля',
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
                            onPressed: (){signUp(context);}, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: prim,
                              minimumSize: Size(360,65),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                              //side: BorderSide(color: Colors.red, width: 5),
                            ),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17
                              ),
                            )
                          ),
                          SizedBox(height: 20,),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Back',
                              style: GoogleFonts.balsamiqSans(
                                backgroundColor: Colors.white,
                                color: prim,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          //Expanded(child: Container(color: Colors.white,))
                        ],
                      ),
                    )
                  ],
                ),
                //Expanded(flex: 1, child: Container(color: Colors.white,))
              ],
            )
          ),
        ],
      ),
    );
  }
}