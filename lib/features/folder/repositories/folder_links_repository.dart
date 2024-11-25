import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tengo/features/models/fse.dart';

class FolderLinksRepository {
  FolderLinksRepository({required this.mainPriorityFse, required this.pattern});
  Fse mainPriorityFse;
  RegExp pattern;
  late Fse _currentPriorityFse;
  late List<Fse> _fsePriorityList;

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
      var path = m[0]!.substring(2, m[0]!.length - 2);
      // print(path);
      if (!(path.contains('../'))) {
        String priority;
        if (path.contains(Platform.pathSeparator)) {
          priority = path.substring(0, path.indexOf(Platform.pathSeparator));
          var priorityDir = Directory(mainPriorityFse.path + priority);
          if (priorityDir.existsSync()) {
            _currentPriorityFse = Fse(
                name: priorityDir.path,
                type: priorityDir.runtimeType.toString(),
                path: mainPriorityFse.path);
            // print(_currentPriorityFse ?? 'not been initialised');
            fsePriorityList.add(
              format(),
            );
          } else {
            // debugPrint('Folder "${priorityDir.path}" not exists');
          }
        } else if (!(path.contains(Platform.pathSeparator))) {
          priority = path;
          var priorityFile = File(mainPriorityFse.path + priority);
          if (priorityFile.existsSync()) {
            _currentPriorityFse = Fse(
                name: priorityFile.path,
                type: priorityFile.runtimeType.toString(),
                path: mainPriorityFse.path);
            fsePriorityList.add(format());
          } else {
            debugPrint('File "${priorityFile.path}" not Exists');
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
    return path.substring(
        0, path.length - path.indexOf(Platform.pathSeparator));
  }

  format() {
    _currentPriorityFse.name = _currentPriorityFse.name.substring(
        _currentPriorityFse.name.lastIndexOf(Platform.pathSeparator) + 1);
    if (_currentPriorityFse.type == '_Directory') {
      _currentPriorityFse.name += Platform.pathSeparator;
    }
    return _currentPriorityFse;
    // return _currentFolderFse;
  }
}
