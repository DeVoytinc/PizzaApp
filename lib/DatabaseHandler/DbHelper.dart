import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../UserModel.dart';

class DbHelper {
  static Database? _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_userID = 'user_id';
  static const String C_userEmail = 'email';
  static const String C_userPassword = 'password';

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
      ' $C_userID TEXT, '
      ' $C_userEmail TEXT, '
      ' $C_userPassword TEXT, '
      ' PRIMARY KEY ($C_userID)'
      ')');
      
  }

  Future<UserModel> saveData(UserModel user) async{
    var dbClient = await db;
    user.userId = (await dbClient?.insert(Table_User, user.toMap())) as String;
    return user;
  }

  Future<UserModel?> getLoginUser(String id, String paswr) async {
    var dbClient = await db;
    var res = await dbClient?.rawQuery("SELECT * FROM $Table_User WHERE "
    "$C_userID = '$id' AND "
    "$C_userPassword = '$paswr'"
    );

    if (res!.length > 0) {
      return UserModel.fromMap(res.first);
    }

    return null;
  }
}

