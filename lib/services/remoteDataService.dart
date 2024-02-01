import 'package:car_renting/models/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addCar(Car car) async {
    DocumentReference documentReference = db.collection('Cars').doc();

    documentReference.set(car.toJson()).whenComplete(() {
      return "Successfully added to the database";
    }).catchError((e) {
      return e;
    });
    return '';
  }

  Stream<List<Car>> getCarsList(String orderBy) {
    Query<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('Cars');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((e) {
        Map<String, dynamic> data = e.data();
        data['id'] = e.id;
        return Car.fromJson(data);
      }).toList();
    });
  }

  Future<String> update(Car car) async {
    DocumentReference documentReferencer = db.collection('Cars').doc(car.id);
    documentReferencer.update(car.toJson()).whenComplete(() {
      return "Sucessfully added to the database";
    }).catchError((e) {
      return e;
    });
    return '';
  }

  Future<String> delete(Car car) async {
    DocumentReference documentReferencer = db.collection('Cars').doc(car.id);
    documentReferencer.delete().whenComplete(() {
      return "Sucessfully deleted from database";
    }).catchError((e) {
      return e;
    });
    return '';
  }
}
