import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app_second/additional_info_Item.dart';
import 'package:flutter_weather_app_second/keys.dart';
import 'package:flutter_weather_app_second/weather_forecast_card.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  double tempInCelcius = 0;
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      String cityName = 'Colombo';
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$apiKey",
        ),
      );
      //converting json body
      final data = jsonDecode(res.body);
      //checking weather api gives response
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      setState(() {
        temp = data['list'][0]['main']["temp"];
        tempInCelcius = (temp - 273.15).toDouble();
        tempInCelcius = double.parse(tempInCelcius.toStringAsFixed(1));
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
      ),
      body: temp == 0
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //current location and weather
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              children: [
                                Text(
                                  '$tempInCelcius °C',
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                const Icon(
                                  Icons.cloud,
                                  size: 65,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Rain',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //weather forecast
                  const SizedBox(height: 18),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weather Forecast',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            WeatherForecastCard(
                                time: '9:00AM',
                                temp: '26 \u00B0C',
                                icon: Icons.cloud),
                            WeatherForecastCard(
                                time: '9:00AM',
                                temp: '26 \u00B0C',
                                icon: Icons.cloud),
                            WeatherForecastCard(
                                time: '9:00AM',
                                temp: '26 \u00B0C',
                                icon: Icons.cloud),
                            WeatherForecastCard(
                                time: '9:00AM',
                                temp: '26 \u00B0C',
                                icon: Icons.cloud),
                            WeatherForecastCard(
                                time: '9:00AM',
                                temp: '26 \u00B0C',
                                icon: Icons.cloud),
                            WeatherForecastCard(
                                time: '9:00AM',
                                temp: '26 \u00B0C',
                                icon: Icons.cloud),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  //additional info
                  const Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AdditionalInfoItem(
                          icon: Icons.water_drop_outlined,
                          label: 'Humidity',
                          percentage: "94%",
                        ),
                        AdditionalInfoItem(
                          icon: Icons.air_outlined,
                          label: 'Wind',
                          percentage: "5 km/h",
                        ),
                        AdditionalInfoItem(
                          icon: Icons.beach_access,
                          label: 'Pressure',
                          percentage: "10 psi",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
