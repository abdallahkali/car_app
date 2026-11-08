class Booking {
  final String carId;
  final String name;
  final String phone;
  final DateTime date;
  final String time;
  final String notes;

  const Booking({
    required this.carId,
    required this.name,
    required this.phone,
    required this.date,
    required this.time,
    this.notes = '',
  });

  Map<String, dynamic> toJson() => {
        'car_id': carId,
        'name': name,
        'phone': phone,
        'date': date.toIso8601String(),
        'time': time,
        'notes': notes,
      };
}
