
import 'package:flutter_application_1/pizza_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import '../HomePage.dart';
import 'pizzeslist.dart';


class FillPizzes {

  
static Database? _db;

  static const String DB_Name = 'pizza.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_name = 'name';
  static const String C_description = 'description';
  static const String C_imagepath = 'imagepath';
  static const String C_price = 'price';
  static const String C_rating = 'rating';
  
  Future<Database?> get db async{
    if (_db != null){
      return _db;
    }

    _db = await initDb();

    return _db;
  } 

  initDb() async{
  io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, DB_Name);
  var db = await openDatabase(path, version: Version, onCreate: _onCreate);
  return db;
  } 

  _onCreate(Database db, int intVersion) async{
    await db.execute('CREATE TABLE $Table_User ('
      ' $C_name TEXT, '
      ' $C_description TEXT, '
      ' $C_imagepath TEXT, '
      ' $C_price INTEGER, '
      ' $C_rating INTEGER'
      ')');

    for (var i = 0; i < newestpizzes.length; i++) {
        db.insert(Table_User, newestpizzes[i].toMap());
    }
      
  }

  // Future<Pizza> saveData(Pizza user) async{
  //   var dbClient = await db;
  //   user.name = (await dbClient?.insert(Table_User, {C_name:user.name, C_description:user.description, C_imagepath:user.imagePath, C_price:user.price, C_rating:user.rating,})).toString();
  //   return user;
  // }

  Future<List<Pizza>> getMapList() async {
    var dbClient = await db;
    var res = await dbClient?.query(Table_User);

    List<Pizza> result = [];

    for (var i = 0; i < res!.length; i++) {
      result.add(Pizza.fromMap(res[i]));
    }

    return result;
  }

    Future<List<Pizza>> getSortedMapList(String text) async {
    var dbClient = await db;
    String sorting = onUp ? 'DESC' : 'ASC';
    var res = await dbClient?.rawQuery("SELECT * FROM $Table_User WHERE $C_name LIKE '%$text%' ORDER BY $C_rating $sorting");

    List<Pizza> result = [];

    for (var i = 0; i < res!.length; i++) {
      result.add(Pizza.fromMap(res[i]));
    }

    return result;
  }



}

