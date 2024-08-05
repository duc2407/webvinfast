class Product {
  final int id;
  final String name;
  final String image;
  final int colorId;
  final String? type;
  final String? line;
  final int numberOfSeats;
  final int price;
  final double length;
  final double width;
  final double height;
  final double pin;
  final String typeLaZang;
  final int airbagNumber;
  final String? consumption;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.colorId,
    this.type,
    this.line,
    required this.numberOfSeats,
    required this.price,
    required this.length,
    required this.width,
    required this.height,
    required this.pin,
    required this.typeLaZang,
    required this.airbagNumber,
    this.consumption,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      colorId: json['colorId'],
      type: json['type'],
      line: json['line'],
      numberOfSeats: json['number_of_seats'],
      price: json['price'],
      length: json['length'].toDouble(),
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      pin: json['pin'].toDouble(),
      typeLaZang: json['type_la_zang'],
      airbagNumber: json['airbag_number'],
      consumption: json['Consumption'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
