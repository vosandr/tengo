import 'dart:async';
import 'dart:io';

import 'package:tengo_viewer/repositories/fse/models/fse.dart';
import 'link_repository.dart';

class FolderRepository {
  FolderRepository();
  Stream<List<Fse>> showFolderData(
      {required String path, required Fse priorityFse}) async* {
    // folder = Folder();
    List<Fse> linkedFseList = LinkRepository().showPriorityFseList(
        priorityFse: priorityFse, pattern: RegExp(r'\[\[.*?\]\]'));
    List<Fse> sortedFseList = [];

    var dataList = Directory(path).listSync();

    // print('$priorityPath ${fse.name}');
    for (var data in dataList) {
      Fse fse = format(Fse(name: data.path, type: data.runtimeType.toString()));
      if (linkedFseList.every((linkedFse) => linkedFse.name != fse.name)) {
        sortedFseList.add(fse);
      }
    }
    yield linkedFseList + sort(sortedFseList);
  }

  List<Fse> sort(List<Fse> fseList) {
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
    return fseList;
  }

  Fse format(Fse fse) {
    fse.name = fse.name.substring(fse.name.lastIndexOf('/') + 1);
    if (fse.type == '_Directory') {
      fse.name += '/';
    }
    return fse;
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

  // Fse format(Fse fse) {
  //   fse.name = fse.name.substring(fse.name.lastIndexOf('/') + 1);
  //   if (fse.type == '_Directory') {
  //     fse.name += '/';
  //   }
  //   return fse;
  // }

  // List<Fse> sort(
  //     List<Fse> fseList, List<Fse> notSortingArray, Fse notSortingFse) {
  //   fseList.removeWhere((removingFse) =>
  //       notSortingArray.contains(removingFse) || removingFse == notSortingFse);
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

  //   return [notSortingFse] + notSortingArray + fseList;
  // }

  // List<Fse> getLinksInFile(Fse fse) {
  //   var list = <Fse>[];
  //   var fileContent = File(fse.path + fse.name).readAsStringSync();

  //   var exp = RegExp(r'\[\[.*?\]\]');
  //   var matches = exp.allMatches(fileContent);
  //   for (var match in matches) {
  //     var element = match.input;
  //     if (File(element).existsSync()) {
  //       list.add(Fse(
  //           name: element,
  //           path: fse.path,
  //           type: File(element).runtimeType.toString()));
  //     }
  //   }
  //   return list;
  // }
}
