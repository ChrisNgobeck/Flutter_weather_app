# Weather App Documentation

## Overview

The Weather App is a Flutter application designed to provide users with current weather information based on their location or a specified city. It fetches data from the OpenWeatherMap API and displays temperature, weather condition, and other related data.

## Key Components

- Main Function
The entry point of the application, responsible for running the app and initializing the MyApp widget.

- MyApp Widget
Serves as the root widget of the application. It sets up a MaterialApp with the WeatherPage as the home screen.

- Weather Model
Defines the Weather class to store weather data, including temperature, condition, high and low temperatures, sunrise and sunset times. It includes a factory constructor to create instances from JSON data.

- WeatherService
Handles API requests to OpenWeatherMap. It has methods to fetch weather data by city name and to determine the user's current city based on their geographic location.

- WeatherPage Widget
A stateful widget that displays the weather information. It shows loading animations while fetching data and presents the weather details upon retrieval.

## Usage

Fetch Weather Data: Upon launching, the app attempts to fetch the weather for the user's current location. It falls back to a specified city if location permissions are denied.
Display Data: Displays an animated representation of the current weather condition, along with the temperature, high/low temperatures, sunrise and sunset times, and the city name.
Error Handling: In case of an error during data retrieval, the app displays an appropriate message to the user.
Development Environment

- Flutter SDK
Dart language
External packages: http, geolocator, geocoding, intl, lottie

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# Flutter_weather_app


https://github.com/ChrisNgobeck/Flutter_weather_app/assets/150654899/bd59fff5-0c8d-4903-b53f-29a744e25753

