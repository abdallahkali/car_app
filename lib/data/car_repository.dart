import '../models/booking.dart';
import '../models/car.dart';

abstract class CarRepository {
  Future<List<Car>> getCars();
  Future<Car> addCar(Car car);
  Future<void> submitBooking(Booking booking);
}
