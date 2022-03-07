
import 'package:flutter/foundation.dart';

import 'package:mobx/mobx.dart';
part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
 ValueNotifier<bool> opacity = ValueNotifier(false);
 

  Future<void> changeOpacity() async {
    opacity.value = true;
  }
}


