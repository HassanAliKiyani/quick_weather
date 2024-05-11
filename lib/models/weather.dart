class Weather {
  final String mainCondition;
  final String description;
  final double temperature;
  final double feelsLike;
  final String cityName;
  final DateTime sunrise;
  final DateTime sunset;

  Weather({
    required this.mainCondition,
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.cityName,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJSON(Map<String, dynamic> json) {
    return Weather(
        mainCondition: json["weather"][0]["main"],
        description: json["weather"][0]["description"],
        temperature: json["main"]["temp"].toDouble(),
        feelsLike: json["main"]["feels_like"].toDouble(),
        cityName: json["name"],
        sunrise:
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
        sunset:
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000));
  }
}
