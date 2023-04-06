class Pizza{

  String name;
  String description;
  String imagePath;
  int price;
  double rating;

  late int count = 1;

  Pizza({
    required this.name, 
    required this.description, 
    required this.imagePath, 
    required this.price, 
    required this.rating 
  });
}