import 'package:crud_firebase/viewmodels/home_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeViewModel Tests -', () {
    test('When Initialise is called, should WeatherData should not be empty',
        () async {
      var model = HomeViewModel();
      model.initialise();
      expect(model.allWeatherData.isNotEmpty,
          true); // verify(Image picker was called )
    });
  });
}
