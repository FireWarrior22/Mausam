import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {},
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  hintText: 'Enter City Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                onChanged: (value){
                  cityName=value;
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, cityName);
              },
              child: Text(
                'Get Weather',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.black54,
                shadowColor: Colors.lightBlueAccent,
                elevation: 5,
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
