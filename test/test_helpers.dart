import 'package:mockito/mockito.dart';

class TestHelpers {
  static final Exception testException = Exception('Test Exception');

  static void noMoreInteractions(List<dynamic> mocks) {
    for (final mock in mocks) {
      verifyNoMoreInteractions(mock);
    }
  }

  static void resetMocks(List<dynamic> mocks) {
    for (final mock in mocks) {
      reset(mock);
    }
  }
}
