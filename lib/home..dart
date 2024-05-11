import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather/models/weather.dart';
import 'package:minimal_weather/services/weather_services.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _weatherService =
      WeatherServices(apiKey: "API-KEY");

  Weather? _weather;

  bool? isLocationEnabled;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // City Name
              IconButton(
                  onPressed: _fetchWeather,
                  icon: const Icon(Icons.location_on_rounded)),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  _weather?.cityName.toUpperCase() ?? "Loading City...",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 4),
                ),
              ),
              _fetchLottieAnimation(),
              //Temperature

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  "${_weather?.temperature.round()} °C",
                  style: GoogleFonts.roboto(fontSize: 36),
                ),
              ),
              Text(
                "${_weather?.mainCondition}",
                style: GoogleFonts.roboto(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fetchLottieAnimation() {
    switch (_weather?.mainCondition) {
      case "Clouds":
        return LottieBuilder.asset("lib/images/cloudy.json");
      case "Rain":
        return LottieBuilder.asset("lib/images/rain.json");
      case "Thunder":
        return LottieBuilder.asset("lib/images/thunder.json");
      case "Snow":
        return LottieBuilder.asset("lib/images/snow.json");
      case "Sun" || "Sunny":
        return LottieBuilder.asset("lib/images/sunny.json");
      default:
        return LottieBuilder.asset("lib/images/sunny.json");
    }
  }

  _fetchWeather() async {
    String city = await _weatherService.getCurrentCity();

    try {
      if (city == "") {
        //Empty city either due to failed permission or empty in geolocator
        setState(() {
          isLocationEnabled = false;
        });
        city = "Barcelona";
      } else {
        final weather = await _weatherService.getWeather(city: "barcelona");
        setState(() {
          _weather = weather;
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
