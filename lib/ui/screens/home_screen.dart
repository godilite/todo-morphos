import 'dart:ui';

import 'package:crud_firebase/constants/routes.dart';
import 'package:crud_firebase/models/weather.dart';
import 'package:crud_firebase/utils/util_functions.dart';
import 'package:crud_firebase/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchTextCon = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    //Add search controller listener
    _searchTextCon.addListener(() {
      setState(() {
        _searchQuery = _searchTextCon.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, snapshot) {
          List<Weather> allWeatherData = model.allWeatherData;
          final searchWeatherList = _searchTextCon.text.isEmpty
              ? []
              : allWeatherData
                  .where((wth) => wth.location.name.contains(new RegExp(
                      escapeSpecial(_searchQuery),
                      caseSensitive: false))||
                wth.location.country.contains(new RegExp(escapeSpecial(_searchQuery),
                    caseSensitive: false)) )
                  .toList();
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: _isSearching
                      ? AppBar(
                          elevation: 0.0,
                          brightness: Brightness.dark,
                          centerTitle: false,
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 25.0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _searchTextCon.clear();
                                _isSearching = false;
                              });
                            },
                          ),
                          title: TextField(
                            autofocus: true,
                            controller: _searchTextCon,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              hintText: "Search city or country ..",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  print(_searchTextCon.text);
                                  _searchTextCon.clear();
                                },
                              ),
                            ),
                          ),
                        )
                      : AppBar(
                          elevation: 0.0,
                          brightness: Brightness.dark,
                          centerTitle: false,
                          
                          title: Text("Section One",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          actions: [
                             Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: TextButton(
                                onPressed: () => Navigator.pushNamed(context, Routes.taskViewRoute) ,child: Text("section 2", style: TextStyle(color: Colors.white),)
                              
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isSearching = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            
                          ],
                        )),
            ),
            body:  _searchQuery.isEmpty ? allWeatherData.length == 0 ? Padding(padding: const EdgeInsets.only(top:50), child: 
            Align(alignment: Alignment.topCenter,
              child: Text("No Data found"),),) :ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                itemCount: allWeatherData.length,
                itemBuilder: (context, index) {
                  final Weather single = allWeatherData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue,
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
                }) :  searchWeatherList.length == 0 ? Padding(padding: const EdgeInsets.only(top:50), child: 
            Align(alignment: Alignment.topCenter,
              child: Text("No match found"),),) :ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                itemCount: searchWeatherList.length,
                itemBuilder: (context, index) {
                  final Weather single = searchWeatherList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue,
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
