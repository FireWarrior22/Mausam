import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String cityName, backgroundImage, dn;
  int temperature, humidity, pressure;
  var date = DateTime.now();
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        backgroundImage = weather.getWeatherStatus(1000);
        cityName = 'Error 404';
        humidity = 0;
        pressure = 0;
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      int condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      humidity = weatherData['main']['humidity'];
      pressure = weatherData['main']['pressure'];
      backgroundImage = weather.getWeatherStatus(condition);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () async {
            var typedName = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CityScreen();
                },
              ),
            );
            print(typedName);
            if (typedName != null) {
              var weatherData = await weather.getCityWeather(typedName);
              updateUI(weatherData);
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () async {
              var weatherData = await weather.getLocationWeather();
              updateUI(weatherData);
            },
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'images/$backgroundImage.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 150),
                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${date.day}/${date.month}/${date.year}',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temperature\u2103',
                              style: GoogleFonts.lato(
                                fontSize: 85,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white30,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Pressure',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$pressure',
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'hPa',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Humidity',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$humidity',
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'g/kg',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
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
