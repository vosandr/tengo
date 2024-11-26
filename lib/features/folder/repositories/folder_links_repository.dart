import 'dart:io';

import 'package:cardoteka/cardoteka.dart';
import 'package:flutter/material.dart';
import 'package:tengo/features/models/fse.dart';
import 'package:tengo/features/settings/settings_cards.dart';

class FolderLinksRepository {
  FolderLinksRepository({required this.mainPriorityFse, required this.pattern});
  Fse mainPriorityFse;
  RegExp pattern;
  late Fse _currentPriorityFse;
  late List<Fse> _fsePriorityList;
  final settings = SettingsCardoteka(
      config: CardotekaConfig(
          name: 'settings',
          cards: SettingsCards.values,
          converters: SettingsCards.converters));
  String _changePathSeparator(String path) {
    if (Platform.pathSeparator != settings.get(SettingsCards.pathSeparator)) {
      return path.replaceAll(
          Platform.pathSeparator, settings.get(SettingsCards.pathSeparator));
    } else {
      return path;
    }
  }

  List<Fse> showPriorityFseList() {
    List<Fse> fsePriorityList = [];

    File file = File(mainPriorityFse.path + mainPriorityFse.name);
    if (!file.existsSync()) {
      return fsePriorityList;
    }
    String fileContent = file.readAsStringSync();
    fsePriorityList.add(mainPriorityFse);
    var matches = pattern.allMatches(fileContent.toString());
    for (final Match m in matches) {
      var path = m[0]!;
      // print(path);
      if (!(path.contains('../')) ||
          !(path.contains(RegExp(r'#\d+'))) ||
          !(path.contains('#')) ||
          !(path.contains('##'))) {
        String priority;
        if (path.contains(settings.get(SettingsCards.pathSeparator))) {
          priority = path.substring(
              0, path.indexOf(settings.get(SettingsCards.pathSeparator)));
          var priorityDir = Directory(mainPriorityFse.path + priority);
          if (priorityDir.existsSync()) {
            _currentPriorityFse = Fse(
              name: _changePathSeparator(priorityDir.path),
              type: priorityDir.runtimeType.toString(),
              path: _changePathSeparator(mainPriorityFse.path),
            );
            // print(_currentPriorityFse ?? 'not been initialised');
            fsePriorityList.add(
              format(),
            );
          } else {
            // debugPrint('Folder "${priorityDir.path}" not exists');
          }
        } else if (!(path
            .contains(settings.get(SettingsCards.pathSeparator)))) {
          priority = path;
          var priorityFile = File(mainPriorityFse.path + priority);
          if (priorityFile.existsSync()) {
            _currentPriorityFse = Fse(
              name: _changePathSeparator(priorityFile.path),
              type: priorityFile.runtimeType.toString(),
              path: _changePathSeparator(mainPriorityFse.path),
            );
            fsePriorityList.add(format());
          } else {
            debugPrint(
                'File "${_changePathSeparator(priorityFile.path)}" not Exists');
          }
        }
      }
    }

    return fsePriorityList;
  }

  toAbsolute({required String path}) {
    if (path.contains('../')) {
      path = path.substring(path.indexOf('../'));
    }
  }

  toAbsoluteLink({required String path, required String name}) {
    if (name.contains('../')) {
      toParent(path: path);
      toAbsoluteLink(path: path, name: name);
    }
    if (name[0] == '#' || name.substring(0, 1) == './' && name[2] == '#') {
      // for() {

      // }
    }
    return path;
  }

  String toParent({required String path}) {
    return path.substring(0,
        path.length - path.indexOf(settings.get(SettingsCards.pathSeparator)));
  }

  format() {
    _currentPriorityFse.name = _currentPriorityFse.name.substring(
        _currentPriorityFse.name
                .lastIndexOf(settings.get(SettingsCards.pathSeparator)) +
            1);
    if (_currentPriorityFse.type == '_Directory') {
      _currentPriorityFse.name += settings.get(SettingsCards.pathSeparator);
    }
    return _currentPriorityFse;
    // return _currentFolderFse;
  }
}
