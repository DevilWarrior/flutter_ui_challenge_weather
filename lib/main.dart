import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/forecast/forecast.dart';
import 'package:weather/forecast/app_bar.dart';
import 'package:weather/forecast/background/background_with_rings.dart';
import 'package:weather/forecast/week_drawer.dart';
import 'package:weather/generic_widgets/sliding_drawer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Weather',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  String selectedDate = 'Thursday, August 27';
  OpenableController openableController;

  @override
  void initState() {
    super.initState();

    openableController = new OpenableController(
        vsync: this,
        openDuration: const Duration(milliseconds: 250)
    )
    ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Forecast(),

          // App Bar
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: new ForecastAppBar(
              dateText: selectedDate,
              onDrawerArrowTap: openableController.open,
            ),
          ),

          // Right Drawer
          new SlidingDrawer(
            openableController: openableController,
            drawer: new WeekDrawer(
              onDaySelected: (String title) {
                setState(() => selectedDate = title.replaceAll('\n', ', '));
                openableController.close();
              },
            ),
          ),
        ],
      ),
    );
  }
}

