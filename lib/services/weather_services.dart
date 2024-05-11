import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:minimal_weather/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  static const String BASE_URL =
      "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherServices({required this.apiKey});

  Future<Weather> getWeather({required String city}) async {
    // final responsehttps =await http.get(Uri.parse('$BASE_URL??lat={lat}&lon={lon}&appid=$apiKey'));
    final httpsResponse = await http
        .get(Uri.parse('$BASE_URL?q=$city&appid=$apiKey&units=metric'));

    if (httpsResponse.statusCode == 200) {
      return Weather.fromJSON(jsonDecode(httpsResponse.body));
    } else {
      throw ("FAILED TO LOAD DATA ERROR ${httpsResponse.statusCode}");
    }
  }

  Future<String> getCurrentCity() async {
    bool checkLocation = await Geolocator.isLocationServiceEnabled();
    if (checkLocation) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        //Ask for location Permission
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          //User is denying again so handle manual or just display error
          return "";
        } else if (permission == LocationPermission.unableToDetermine) {
          //User is denying again so handle manual or just display error
          return "";
        } else if (permission == LocationPermission.deniedForever) {
          //User is denying again so handle manual or just display error
          return "";
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      //Getting placemarks
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      //City name extraction form the placemarks for first location
      String? city = placemarks[0].locality;
      // print(placemarks[0].toJson());

      return city ?? "";
    } else {
      return "";
    }
  }
}
