class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double highTemp; // High temperature for the day
  final double lowTemp; // Low temperature for the day
  final DateTime sunrise; // Sunrise time
  final DateTime sunset; // Sunset time
  

  

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.highTemp,
    required this.lowTemp,
    required this.sunrise,
    required this.sunset,

    
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
  return Weather(
    cityName: json['name'] ?? 'Unknown', // Provide a default value in case it's null
    temperature: (json['main']['temp'] as num?)?.toDouble() ?? 0.0,
    mainCondition: (json['weather'][0]['main'] as String?) ?? 'Unknown',
    highTemp: (json['main']['temp_max'] as num?)?.toDouble() ?? 0.0,
    lowTemp: (json['main']['temp_min'] as num?)?.toDouble() ?? 0.0,
    sunrise: DateTime.fromMillisecondsSinceEpoch(
        (json['sys']['sunrise'] as int? ?? 0) * 1000),
    sunset: DateTime.fromMillisecondsSinceEpoch(
        (json['sys']['sunset'] as int? ?? 0) * 1000),
  );
}
}