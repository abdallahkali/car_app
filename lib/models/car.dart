class Car {
  final String id;
  final String brand;
  final String name;
  final int year;
  final int price;
  final int mileage;
  final String fuel;
  final String transmission;
  final String bodyType;
  final String colorName;
  final int colorValue;
  final int horsepower;
  final int engineCc;
  final String description;
  final List<String> features;
  final List<String> imageUrls;
  final bool featured;

  const Car({
    required this.id,
    required this.brand,
    required this.name,
    required this.year,
    required this.price,
    required this.mileage,
    required this.fuel,
    required this.transmission,
    required this.bodyType,
    required this.colorName,
    required this.colorValue,
    required this.horsepower,
    required this.engineCc,
    required this.description,
    required this.features,
    this.imageUrls = const [],
    this.featured = false,
  });

  bool get isNew => mileage == 0;
  String get title => '$brand $name';

  factory Car.fromJson(Map<String, dynamic> j) => Car(
        id: j['id'].toString(),
        brand: j['brand'],
        name: j['name'],
        year: j['year'],
        price: j['price'],
        mileage: j['mileage'] ?? 0,
        fuel: j['fuel'],
        transmission: j['transmission'],
        bodyType: j['body_type'],
        colorName: j['color_name'] ?? '',
        colorValue: j['color_value'] ?? 0xFF9E9E9E,
        horsepower: j['horsepower'] ?? 0,
        engineCc: j['engine_cc'] ?? 0,
        description: j['description'] ?? '',
        features: List<String>.from(j['features'] ?? const []),
        imageUrls: List<String>.from(j['images'] ?? const []),
        featured: j['featured'] ?? false,
      );
}
