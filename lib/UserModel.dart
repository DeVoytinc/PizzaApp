class UserModel{
  late String userId;
  late String email;
  late String password;
  
  UserModel(this.userId, this.email, this.password);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'user_id': userId,
      'email': email,
      'password' : password,
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map){
    userId = map['user_id'];
    email = map['email'];
    password = map['password'];
  }
}