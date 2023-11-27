import 'package:flutter/material.dart';
import 'package:sky_cast/models/weather_model.dart';
import 'package:sky_cast/services/weather_service.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
}
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(dotenv.env['API_KEY'].toString());
  Weather? _weather;
  var hour = DateTime.now();
  var bgColor = const Color.fromARGB(255, 26, 26, 26);
  var textColor = Colors.white;
  String x = "°C";

  _fetchWeather() async {
    String cityName = await _weatherService.getLocation();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        if (hour.hour>17 && hour.hour<=4) {
          bgColor = Colors.white;
        }
        textColor = (bgColor.computeLuminance() < 0.5)? const Color.fromARGB(255, 202, 196, 196): const Color.fromARGB(255, 67, 67, 67);
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation() {
    if (_weather?.icon == null) {
      return 'assets/01d.json';
    } else {
      return 'assets/${_weather?.icon}.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(
                  Icons.location_on,
                  color: textColor,
                  size: 30,
                ),
                Text(
                  _weather?.cityName ?? "loading city...",
                  style: GoogleFonts.getFont('Teko',color: textColor,fontSize: 50,fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              children: [
                Lottie.asset(getWeatherAnimation()),
                Text(
                  _weather?.weatherConditon ?? "",
                  style: GoogleFonts.getFont('Teko',color: textColor,fontSize: 30,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              '${_weather?.temperature.round() ?? ""}°',
              style: GoogleFonts.getFont('Teko',color: textColor,fontSize: 50,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
