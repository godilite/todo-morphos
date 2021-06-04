import 'package:crud_firebase/constants/api_constant.dart';
import 'package:crud_firebase/models/weather.dart';
import 'package:crud_firebase/utils/api_request.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

 class HomeViewModel extends BaseViewModel {
  var weatherBox;
  List<String> cities = [
    'New york',
    'London',
    'Istanbul',
    'Lagos',
    'Abuja',
    'Madrid',
    'Calabar',
    'Paris',
    'Berlin',
    'Accra',
  ];
  List<Weather> allWeatherData = [];
  void initialise() async {
    weatherBox = await Hive.openBox<Weather>('weatherBox');
    await getAllSavedWeatherData();
    await getAllCitiesCurrentWeather();
  }

  Future<void> getAllSavedWeatherData() async {
    allWeatherData = weatherBox.values.toList();
    notifyListeners();
  }

  Future getAllCitiesCurrentWeather() async {
    if (weatherBox == null) {
      weatherBox = await Hive.openBox<Weather>('weatherBox');
    }
    for (int i = 0; i < cities.length; i++) {
      Map<String, dynamic> queryParam = {
        'access_key': API_ACCESS_KEY,
        'query': cities[i]
      };
      final response =
          await getResquest(url: 'current', queryParam: queryParam);
      if (response?.statusCode == 200 && response?.data['success'] != false)  {
        final Weather singleData = Weather.fromJson(response.data);
        await weatherBox.put(i, singleData);
      }
    }
    await getAllSavedWeatherData();
  }

}
