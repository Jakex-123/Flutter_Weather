class Weather {
  final String cityName;
  final double temperature;
  final String weatherConditon;
  final String icon;

  Weather(
      {required this.cityName,
      required this.weatherConditon,
      required this.temperature,required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        weatherConditon: json['weather'][0]['main'],
        icon: json['weather'][0]['icon']);
  }
}
