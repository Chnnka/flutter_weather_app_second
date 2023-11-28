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
  Future<Map<String, dynamic>> getCurrentWeather() async {
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
      return data;
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
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          //temperature
          final temp = currentWeatherData['main']['temp'];
          var currentTemp = (temp - 273.15).toDouble();
          currentTemp = double.parse(currentTemp.toStringAsFixed(1));
          //sky
          final currentSky = currentWeatherData['weather'][0]['main'];
          //pressure
          final currentPressure = currentWeatherData['main']['pressure'];
          //wind
          final currentWind = currentWeatherData['wind']['speed'];
          //humidity
          final currentHumidity = currentWeatherData['main']['humidity'];

          return Padding(
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
                                '$currentTemp °C',
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 65,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                currentSky,
                                style: const TextStyle(fontSize: 25),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weather Forecast',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       for (int i = 0; i < 10; i++)
                    //         WeatherForecastCard(
                    //             time: data['list'][i + 1]['dt'].toString(),
                    //             temp: ((data['list'][i + 1]['main']['temp']) -
                    //                         273.15)
                    //                     .toStringAsFixed(2) +
                    //                 ' \u00B0C',
                    //             icon: data["list"][i + 1]['weather'][0]
                    //                             ['main'] ==
                    //                         'Cloud' ||
                    //                     data["list"][i + 1]['weather'][0]
                    //                             ['main'] ==
                    //                         'Rain'
                    //                 ? Icons.cloud
                    //                 : Icons.sunny),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final hourlyForecast = data['list'][index + 1];
                          final hourlySky =
                              data["list"][index + 1]['weather'][0]['main'];
                          final hourlyTemp =
                              ((hourlyForecast['main']['temp']) - 273.15);
                          return WeatherForecastCard(
                            time: hourlyForecast['dt_txt'].toString(),
                            icon: hourlySky == 'Cloud' || hourlySky == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                            temp: hourlyTemp,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                //additional info
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop_outlined,
                        label: 'Humidity',
                        percentage: "$currentHumidity",
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air_outlined,
                        label: 'Wind',
                        percentage: '${currentWind}Km/h',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        percentage: "$currentPressure",
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
