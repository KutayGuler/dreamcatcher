// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observables.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$S on DreamStateBase, Store {
  late final _$currentDreamIDAtom =
      Atom(name: 'DreamStateBase.currentDreamID', context: context);

  @override
  String get currentDreamID {
    _$currentDreamIDAtom.reportRead();
    return super.currentDreamID;
  }

  @override
  set currentDreamID(String value) {
    _$currentDreamIDAtom.reportWrite(value, super.currentDreamID, () {
      super.currentDreamID = value;
    });
  }

  late final _$allDataAtom =
      Atom(name: 'DreamStateBase.allData', context: context);

  @override
  Map<String, dynamic> get allData {
    _$allDataAtom.reportRead();
    return super.allData;
  }

  @override
  set allData(Map<String, dynamic> value) {
    _$allDataAtom.reportWrite(value, super.allData, () {
      super.allData = value;
    });
  }

  late final _$sortedDreamsAtom =
      Atom(name: 'DreamStateBase.sortedDreams', context: context);

  @override
  List<dynamic> get sortedDreams {
    _$sortedDreamsAtom.reportRead();
    return super.sortedDreams;
  }

  @override
  set sortedDreams(List<dynamic> value) {
    _$sortedDreamsAtom.reportWrite(value, super.sortedDreams, () {
      super.sortedDreams = value;
    });
  }

  late final _$DreamStateBaseActionController =
      ActionController(name: 'DreamStateBase', context: context);

  @override
  dynamic setCurrentDreamID(String id) {
    final _$actionInfo = _$DreamStateBaseActionController.startAction(
        name: 'DreamStateBase.setCurrentDreamID');
    try {
      return super.setCurrentDreamID(id);
    } finally {
      _$DreamStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAll(dynamic data) {
    final _$actionInfo = _$DreamStateBaseActionController.startAction(
        name: 'DreamStateBase.setAll');
    try {
      return super.setAll(data);
    } finally {
      _$DreamStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addToData(String key, dynamic value) {
    final _$actionInfo = _$DreamStateBaseActionController.startAction(
        name: 'DreamStateBase.addToData');
    try {
      return super.addToData(key, value);
    } finally {
      _$DreamStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addDream(dynamic dream) {
    final _$actionInfo = _$DreamStateBaseActionController.startAction(
        name: 'DreamStateBase.addDream');
    try {
      return super.addDream(dream);
    } finally {
      _$DreamStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic sortDreamsByTitle(String title) {
    final _$actionInfo = _$DreamStateBaseActionController.startAction(
        name: 'DreamStateBase.sortDreamsByTitle');
    try {
      return super.sortDreamsByTitle(title);
    } finally {
      _$DreamStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic sortDreamsByDate() {
    final _$actionInfo = _$DreamStateBaseActionController.startAction(
        name: 'DreamStateBase.sortDreamsByDate');
    try {
      return super.sortDreamsByDate();
    } finally {
      _$DreamStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentDreamID: ${currentDreamID},
allData: ${allData},
sortedDreams: ${sortedDreams}
    ''';
  }
}
