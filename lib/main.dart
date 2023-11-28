import 'package:flutter/material.dart';
import 'package:sky_cast/pages/weather_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
    await dotenv.load();
  runApp(const SkyCast());
}

class SkyCast extends StatelessWidget {
  const SkyCast({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
