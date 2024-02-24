import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final GetIt di = GetIt.instance;

@InjectableInit()
void setupDI() {
  di.init();
}
