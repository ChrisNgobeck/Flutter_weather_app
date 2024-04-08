import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:my_weather_app/services/weather_service.dart';
import 'package:my_weather_app/models/weather_model.dart';
import 'package:lottie/lottie.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart'; // Consider removing if not explicitly used


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool _isLoading = true; // Correctly utilize this flag
  Weather? _weather;

  final _weatherService = WeatherService(apiKey: '8acc63386b890e3a5becb395f73ad1da');

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    
  }

  Future<void> _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        _isLoading = false; // Update loading state
      });
    } catch (e) {
      // Log error or handle it appropriately
      print(e); // Consider a more user-friendly error handling
      setState(() {
        _isLoading = false;
      });
    }
  }

  String getFormattedTime(DateTime? dateTime) {
    if (dateTime == null) return 'Loading...';
    return DateFormat('h:mm a').format(dateTime.toLocal());
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/loading.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds': return 'assets/suncloud.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog': return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain': return 'assets/rainthunder.json';
      case 'thunderstorm': return 'assets/rainthunder.json';
      case 'snow': return 'assets/snow.json';
      case 'clear': return 'assets/sunny.json';
      default: return 'assets/sunny.json';
    }
  }





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(249, 7, 29, 43),
        title: const Text('Weather App', style: TextStyle(color: Colors.white),
      ),
    ),
    

      backgroundColor: const Color.fromARGB(255, 6, 2, 17),
      body: SingleChildScrollView(
      child: Center(
       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
        // City name
        const SizedBox(height: 20),
       const Icon(
          Icons.location_on,
          size: 80,
         color: Colors.white,
         ), // Add gap
        Text(_weather?.cityName ?? ' City Loading...',
        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        
    
      const Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centers the row contents horizontally
        children: [
           
         SizedBox(width: 10), // Provides spacing between the two texts
          
        ],
      ),

      const SizedBox(height: 10), // Adds some space between the text and the animation
    // Loading animation
    if (_isLoading) // Checks if the data is still loading
      Container(
        child: Lottie.asset(
          'assets/loading.json', // Your Lottie animation file path
          width: 100, // Specify the width of the animation
          height: 100, // Specify the height of the animation
        ),
      ),
        
       const SizedBox(height: 10), // Add gap

        // Animation
        
          Lottie.asset(// Replace this with your desired animation path
            getWeatherAnimation(_weather?.mainCondition), // Assuming this function returns a valid string path
            width: 200, // Set your desired width
            height: 200, // Set your desired height
          ),
        const SizedBox(height: 10), // Add gap

        // Temperature
        Text('${_weather?.temperature.round() ?? ''}°C',
        style: const TextStyle(fontSize: 35, color: Colors.white)),
       const SizedBox(height: 0), // Add gap

        // Weather condition
        Text(_weather?.mainCondition ?? '',
        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      
      // Additional gap before the Row
            const SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Adjust spacing as needed
                children: [
                  // High Temperature Image and Text
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                      children: [
                        Image.asset(
                          'assets/hitemp.png', // High temperature icon
                          width: 50, // Adjust size as needed
                          height: 50, // Adjust size as needed
                        ),
                        const SizedBox(width: 8), // Space between the image and the text
                        Text(
                          'High:\n ${_weather?.highTemp}°C',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  // Low Temperature Image and Text
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                      children: [
                        Image.asset(
                          'assets/lowtemp.png', // Low temperature icon
                          width: 50, // Adjust size as needed
                          height: 50, // Adjust size as needed
                        ),
                        const SizedBox(width: 8), // Space between the image and the text
                        Text(
                          'Low:\n ${_weather?.lowTemp}°C',
                          style:const  TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust this for desired spacing
                children: [
                  // Sunrise Image and Text
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                      children: [
                        Image.asset(
                          'assets/sun.png', // Sunrise icon
                          width: 40, // Adjust size as needed
                          height: 40, // Adjust size as needed
                        ),
                      const SizedBox(width: 8), // Space between the image and the text
                        Text(
                          'Sunrise:\n ${DateFormat('hh:mm a').format(_weather?.sunrise ?? DateTime.now())}',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  // Sunset Image and Text
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                      children: [
                        Image.asset(
                          'assets/moon.png', // Sunset icon
                          width: 30, // Adjust size as needed
                          height: 30, // Adjust size as needed
                        ),
                        const SizedBox(width: 8), // Space between the image and the text
                        Text(
                          'Sunset:\n ${DateFormat('hh:mm a').format(_weather?.sunset ?? DateTime.now())}',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
            ),
          ),
        ),
    );
  }
}

          
              
          
            

      


   
          
          
        
    

  

    

  

