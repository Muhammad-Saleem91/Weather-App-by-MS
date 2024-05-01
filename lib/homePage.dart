import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_api_app/constants.dart';
import 'package:weather_api_app/searchPage.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final WeatherFactory wf = WeatherFactory(weather_Api_key);

  Weather? weather;
  final textController = TextEditingController();
  String? CityName;

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5842A9),
      body: buildUI(),
    );
  }

  void getWeather() {
    wf.currentWeatherByCityName(CityName ?? "Karachi").then((weatherGet) => {
          setState(() {
            weather = weatherGet;
          })
        });
  }

  Widget getCity() {
    return SafeArea(
      child: Column(
        children: [
          // Adjust the height as needed
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: textController,
              onChanged: (value) {},
              style: TextStyle(
                color: Colors.white,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {},
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Enter City'.toUpperCase(),
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                CityName = textController.text;
                getWeather();
              });
            },
            color: Color(0xff331C71),
            child: const Text(
              "Show Weather",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUI() {
    if (weather == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: ListView(
        children: [
          Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getCity(),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                locationHeader(),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.08,
                ),
                DateTimeInfo(),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.05,
                ),
                weatherIcon(),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                CurrentTemperature(),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                moreInfo(),
              ]),
        ],
      ),
    );
  }

  Widget locationHeader() {
    return Text("${weather?.areaName}, ${weather?.country}" ?? "",
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ));
  }

  Widget DateTimeInfo() {
    DateTime now = weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("hh:mm:ss a").format(now),
          style: const TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              " ${DateFormat("dd/MM/yyyy").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://openweathermap.org/img/wn/${weather?.weatherIcon}@4x.png"))),
        ),
        Text(
          weather?.weatherDescription ?? "not found",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget CurrentTemperature() {
    return Text(
      "${weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
          color: Colors.white, fontSize: 90, fontWeight: FontWeight.w500),
    );
  }

  Widget moreInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: const Color(0xff331C71),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max Weather: ${weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Min Weather: ${weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind : ${weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Humidity : ${weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
