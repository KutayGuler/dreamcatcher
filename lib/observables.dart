import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'observables.g.dart';

var uuid = const Uuid();

class S = DreamStateBase with _$S;

abstract class DreamStateBase with Store {
  @observable
  String currentDreamID = "";

  @observable
  Map<String, dynamic> allData = {};

  @observable
  List sortedDreams = [];

  @action
  setCurrentDreamID(String id) => currentDreamID = id;

  @action
  setAll(data) {
    allData = data;
    sortedDreams = allData['dreams'].values.toList();
    sortDreamsByDate();
  }

  @action
  addToData(String key, value) {
    allData[key].add(value);
  }

  @action
  addDream(dream) {
    var id = uuid.v4();
    dream["id"] = id;
    allData["dreams"][id] = dream;
  }

  @action
  sortDreamsByTitle(String title) {
    var dreams = allData["dreams"];
    var _title = title.toLowerCase();
    sortedDreams = dreams.values
        .toList()
        .where((dream) =>
            dream["title"].toLowerCase().contains(_title) ? true : false)
        .toList();
    sortDreamsByDate();
  }

  @action
  sortDreamsByDate() {
    sortedDreams.sort((a, b) => b['date'].compareTo(a['date']));
  }
}

final g = GetIt.instance;

void setup() {
  g.registerSingleton<S>(S());
}
