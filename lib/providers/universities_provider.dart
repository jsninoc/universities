import 'package:flutter/material.dart';
import 'package:universities/models/university.dart';

class UniversitiesProvider with ChangeNotifier {
  late University _university;

  University get university => _university;

  set university(University university) {
    _university = university;
    notifyListeners();
  }

  updateUniversityStudets(String qty) {
    _university.studentsQty = qty;
    notifyListeners();
  }
}