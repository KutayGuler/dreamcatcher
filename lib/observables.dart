import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
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
  addDream(id, dream) {
    allData["dreams"][id] = dream;
    sortDreamsByDate();
    saveFile();
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

  @action
  Future readJson() async {
    final file = await _localFile;
    final contents = await file.readAsString();
    final jsonData = await json.decode(contents);
    setAll(jsonData);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/save.json');
  }

  @action
  Future<File> saveFile() async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(json.encode(allData));
  }
}

final g = GetIt.instance;

void setup() {
  g.registerSingleton<S>(S());
  g<S>().readJson();
}
