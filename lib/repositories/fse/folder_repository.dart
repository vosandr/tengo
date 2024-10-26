import 'dart:async';
import 'dart:io';

import 'package:tengo_viewer_prioritising_files/repositories/fse/models/fse.dart';

class FolderRepository {
  FolderRepository();

  Stream<FileSystemEntity> showFolderData({required String path}) {
    // folder = Folder();
    return Directory(path).list();
  }

  String toAbsolute({required String path}) {
    path = Directory(path).absolute.path;
    if (path.substring(path.length - 3, path.length) == '../') {
      path = path.substring(0, path.length - 3);
      path = path.substring(0, path.lastIndexOf('/'));
      path = path.substring(0, path.lastIndexOf('/') + 1);
    } else if (path.substring(path.length - 2, path.length) == './') {
      path = path.substring(0, path.length - 2);
    }
    return path;
  }

  Stream<Fse> requestToShowFileData(
      {required String name,
      required String type,
      required String path}) async* {
    if (type == '_File') {
      // FileData().setNameAndPath(name: name, path: path);
    }
  }
  // Future<String> resolve({required String path}) {
  //   return Directory(path).resolveSymbolicLinks();
  // }
  // sort({required List<Fse> fseList}) {
  //   fseList.sort((a, b) {
  //     if (a.name.startsWith('.') && b.name.startsWith('.')) {
  //       return a.name.substring(1).compareTo(b.name.toLowerCase().substring(1));
  //     } else if (a.name.startsWith('.')) {
  //       return a.name.substring(1).compareTo(b.name.toLowerCase());
  //     } else if (b.name.startsWith('.')) {
  //       return a.name.compareTo(b.name.toLowerCase().substring(1));
  //     }
  //     return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  //   });
  // }

  Fse format(Fse fse) {
    fse.name = fse.name.substring(fse.name.lastIndexOf('/') + 1);
    if (fse.type == '_Directory') {
      fse.name += '/';
    }
    return fse;
  }

  List<Fse> sort(
      List<Fse> fseList, List<Fse> notSortingArray, Fse notSortingFse) {
    fseList.removeWhere((removingFse) =>
        notSortingArray.contains(removingFse) || removingFse == notSortingFse);
    fseList.sort((a, b) {
      if (a.name.startsWith('.') && b.name.startsWith('.')) {
        return a.name.substring(1).compareTo(b.name.toLowerCase().substring(1));
      } else if (a.name.startsWith('.')) {
        return a.name.substring(1).compareTo(b.name.toLowerCase());
      } else if (b.name.startsWith('.')) {
        return a.name.compareTo(b.name.toLowerCase().substring(1));
      }
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    return [notSortingFse] + notSortingArray + fseList;
  }

  List<Fse> getLinksInFile(Fse fse) {
    var list = <Fse>[];
    var fileContent = File(fse.path + fse.name).readAsStringSync();

    var exp = RegExp(r'\[\[.*?\]\]');
    var matches = exp.allMatches(fileContent);
    for (var match in matches) {
      var element = match.input;
      if (File(element).existsSync()) {
        list.add(Fse(
            name: element,
            path: fse.path,
            type: File(element).runtimeType.toString()));
      }
    }
    return list;
  }
}
