import 'dart:io';

import 'package:tengo_viewer/repositories/fse/folder_repository.dart';
import 'package:tengo_viewer/repositories/fse/models/fse.dart';

class LinkRepository {
  LinkRepository();

  List<Fse> showPriorityFseList(
      {required Fse priorityFse, required RegExp pattern}) {
    List<Fse> fsePriorityList = [];

    File file = File(priorityFse.path + priorityFse.name);
    if (!file.existsSync()) {
      return fsePriorityList;
    }
    String fileContent = file.readAsStringSync();
    fsePriorityList.add(priorityFse);
    var matches = pattern.allMatches(fileContent.toString());
    for (final Match m in matches) {
      var path = m[0]!.substring(2, m[0]!.length - 2);
      if (!(path.contains('../'))) {
        String priority;
        if (path.contains('/')) {
          priority = path.substring(0, path.indexOf('/'));
          var priorityDir = Directory(priority);
          fsePriorityList.add(
            FolderRepository().format(Fse(
                name: priorityDir.path,
                type: priorityDir.runtimeType.toString(),
                path: priorityFse.path)),
          );
        } else if (!(path.contains('/'))) {
          priority = path;
          var priorityFile = File(priority);
          fsePriorityList.add(FolderRepository().format(Fse(
            name: priorityFile.path,
            type: priorityFile.runtimeType.toString(),
            path: priorityFse.path,
          )));
        }
      }
    }

    return fsePriorityList;
  }

  toAbsolute({required String path}) {
    if (path.contains('../')) {
      path.substring(path.indexOf('../'));
    }
  }
}
