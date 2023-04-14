class Pizza{

  late String name;
  late String description;
  late String imagePath;
  late int price;
  late int rating;

  late int count = 1;

  Pizza({
    required this.name, 
    required this.description, 
    required this.imagePath, 
    required this.price, 
    required this.rating 
  });

   Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'name': name,
      'description': description,
      'imagepath' : imagePath,
      'price' : price,
      'rating' : rating,
    };
    return map;
  }

  Pizza.fromMap(Map<String, dynamic> map){
    name = map['name'];
    description = map['description'];
    imagePath = map['imagepath'];
    price = map['price'];
    rating = map['rating'];
  }
}