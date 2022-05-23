import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'observables.g.dart';

class S = DreamStateBase with _$S;

abstract class DreamStateBase with Store {
  @observable
  String currentDreamID = "";

  @action
  setCurrentDreamID(String id) {
    currentDreamID = id;
  }
}

final g = GetIt.instance;

void setup() {
  g.registerSingleton<S>(S());
}
