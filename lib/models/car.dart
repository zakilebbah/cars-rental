import 'package:car_renting/utils/utilFunctions.dart';

class Car {
  final String? id;
  final String? make;
  final String? model;
  final double? price;
  final String? location;
  final String? availability;
  Car(
      {this.id,
      this.make,
      this.model,
      this.price,
      this.location,
      this.availability});
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
        id: MyFunct.getStringFromJson(json, 'id'),
        make: MyFunct.getStringFromJson(json, 'make'),
        model: MyFunct.getStringFromJson(json, 'model'),
        price: MyFunct.getDoubleFromJson(json, 'price'),
        location: MyFunct.getStringFromJson(json, 'location'),
        availability: MyFunct.getStringFromJson(json, 'availability'));
  }

  Map<String, dynamic> toJson() => {
        'make': make,
        'model': model,
        'price': price,
        'location': location,
        'availability': availability
      };
}
