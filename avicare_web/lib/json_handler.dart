import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class GeoJSONHandler {
  static Future<Map<String, dynamic>> loadStatesBoundaries(String country) async {
    // Load GeoJSON file for the specific country
    // You'll need to have these files in your assets
    final String geoJSONString = await rootBundle.loadString(
        'assets/geojson/${country.toLowerCase()}_states.geojson'
    );

    return json.decode(geoJSONString);
  }

  static List<LatLng> parseStatePolygon(Map<String, dynamic> stateFeature) {
    final coordinates = stateFeature['geometry']['coordinates'][0];
    return coordinates.map<LatLng>((coord) {
      return LatLng(coord[1], coord[0]);
    }).toList();
  }
}

class StateDataController extends GetxController {
  final stateData = <String, Map<String, dynamic>>{}.obs;

  void addStateData(String state, Map<String, dynamic> data) {
    stateData[state] = data;
    update();
  }

  Color getStateColor(String state) {
    if (!stateData.containsKey(state)) return Colors.grey.withOpacity(0.3);

    // You can implement custom color logic based on state data
    final data = stateData[state]!;
    if (data['status'] == 'Active regularly') return Colors.green;
    if (data['status'] == 'Less active') return Colors.orange;
    return Colors.red; // Dormant
  }
}