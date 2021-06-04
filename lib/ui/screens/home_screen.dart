import 'package:crud_firebase/constants/routes.dart';
import 'package:crud_firebase/models/weather.dart';
import 'package:crud_firebase/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, snapshot) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                brightness: Brightness.dark,
                title: Text("API Test App (Weather)"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pushNamed(context, Routes.taskViewRoute),
                      child: Text(
                        "Section 2",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
            body: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                itemCount: model.allWeatherData.length,
                itemBuilder: (context, index) {
                  final Weather single = model.allWeatherData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.brown[500],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          height: 75,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.wb_sunny,
                                      color: Colors.white,
                                    ),
                                    Spacer(),
                                    Text(
                                      single.current.temperature.toString(),
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(single.location.name.toString(),
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
