import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universities/models/university.dart';

class UniversityServices {
  Future<List<University>> getUniversities() async {
    List<University> universities = [];
    var url = Uri.parse('https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json');
    var res = await http.get(url);
    List<dynamic> data = json.decode(res.body);
    for (var element in data) {
      University university = University.fromJSON(element);
      universities.add(university);
    }
    return universities;
  }
  
  Future<List<University>> getUniversitiesWithLimit(int limit) async {
    List<University> universities = [];
    var url = Uri.parse('https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json');
    var res = await http.get(url);
    List<dynamic> data = json.decode(res.body);
    for (var i = 0; i < limit; i++) {
      University university = University.fromJSON(data[i]);
      universities.add(university);
    }
    return universities;
  }
}