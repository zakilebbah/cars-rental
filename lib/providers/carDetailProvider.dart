import 'package:car_renting/models/car.dart';
import 'package:car_renting/services/remoteDataService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CarDetailsProvider with ChangeNotifier {
  bool _loading = false;
  final RemoteDataService _remoteDataService = RemoteDataService();
  bool get loading => _loading;
  List<bool> _selectedAvailability = [true, false];
  List<bool> get selectedAvailability => _selectedAvailability;

  String onAvailabilityClick(int index) {
    _selectedAvailability = [false, false];
    _selectedAvailability[index] = true;
    notifyListeners();
    return availability[index];
  }

  void initAvailability() {
    _selectedAvailability = [true, false];
    notifyListeners();
  }

  Future<void> addOrUpdateCar(Car car) async {
    _loading = true;
    notifyListeners();
    if (car.id != null) {
      await _remoteDataService.update(car);
    } else {
      await _remoteDataService.addCar(car);
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> deleteCar(Car car) async {
    await _remoteDataService.delete(car);
  }
}
