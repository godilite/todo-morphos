import 'package:crud_firebase/viewmodels/task_home_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskViewModel Tests -', () {
    test('When initialise is called, firstSyncing shoudl be set to true',
        () async {
      var model = TaskViewModel();
      model.initialise();
      expect(model.firstSyncing, false); // verify(Image picker was called )
    });
  });
}
