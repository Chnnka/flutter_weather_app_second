import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app_second/additional_info_Item.dart';
import 'package:flutter_weather_app_second/weather_forecast_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
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
      body: Padding(
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Text(
                            '26 °C',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Icon(
                            Icons.cloud,
                            size: 65,
                          ),
                          SizedBox(height: 10),
                          Text(
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
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      WeatherForecastCard(),
                      WeatherForecastCard(),
                      WeatherForecastCard(),
                      WeatherForecastCard(),
                      WeatherForecastCard(),
                      WeatherForecastCard(),
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
                    label: 'Humidity',
                    percentage: "94%",
                  ),
                  AdditionalInfoItem(
                    icon: Icons.abc,
                    label: 'Humidity',
                    percentage: "94%",
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
