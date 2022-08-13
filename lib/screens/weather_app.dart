// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/models/weather_locations.dart';
import 'package:project/widgets/buildin_transform.dart';

import 'package:project/widgets/single_weather.dart';
import 'package:project/widgets/slider_dot.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import '../main.dart';

void main() {
  runApp(const MyApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  late String bgImg;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationList[_currentPage].weatherType == 'Sunny') {
      bgImg = 'assets/sun1.jpg';
    } else if (locationList[_currentPage].weatherType == 'Night') {
      bgImg = 'assets/night.jpg';
    } else if (locationList[_currentPage].weatherType == 'Rainy') {
      bgImg = 'assets/rain1.jpg';
    } else if (locationList[_currentPage].weatherType == 'Cloudy') {
      bgImg = 'assets/cloudy1.jpg';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            )),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              // ignore: avoid_print
              onTap: () => print('Menu Clicked'),
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
          child: Stack(
        children: [
          Image.asset(
            bgImg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black38),
          ),
          Container(
            margin: EdgeInsets.only(top: 140, left: 15),
            child: Row(
              children: [
                for (int i = 0; i < locationList.length; i++)
                  if (i == _currentPage) SliderDot(true) else SliderDot(false)
              ],
            ),
          ),
          TransformerPageView(
            scrollDirection: Axis.horizontal,
            transformer: ScaleAndFadeTransformer(),
            viewportFraction: 0.8,
            onPageChanged: _onPageChanged,
            itemCount: locationList.length,
            itemBuilder: ((context, index) => SingleWeather(index)),
          ),
        ],
      )),
    );
  }
}
