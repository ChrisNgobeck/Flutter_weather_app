import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

// ignore: unused_import
import 'package:intl/intl.dart';


import '../models/weather_model.dart';
import 'package:http/http.dart' as http;


class WeatherService {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService({ required this.apiKey});


  Future<Weather> getWeather(String cityName) async {
  final uri = Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    // Parse the error message from the response body if available
    final errorBody = jsonDecode(response.body);
    final errorMessage = errorBody['message'] ?? 'Failed to load weather data';
    throw Exception(errorMessage);
  }
}


  Future<String> getCurrentCity() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Consider returning a default city or prompting the user again
      return "Default City"; // Placeholder for a default city or another form of error handling
    }
  }

  if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      return placemarks[0].locality ?? "Unknown Location";
    } catch (e) {
      // Handle location service errors or return a default city name
      return "Default City"; // Placeholder for error handling
    }
  } else {
    // Handle other permissions or errors
    return "Default City"; // Placeholder for error handling
  }
}

}