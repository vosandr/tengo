import 'dart:async';
import 'dart:io';

import 'package:tengo/features/models/fse_action.dart';
import 'package:tengo/features/models/fse.dart';
import '../../file/repositories/file_links_repository.dart';

class FolderRepository {
  FolderRepository();
  Stream<List<Fse>> showFolderData(
      {required String path, required Fse priorityFse}) async* {
    // folder = Folder();
    List<Fse> linkedFseList = FileLinksRepository().showPriorityFseList(
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

  FileSystemEntity getFseType({required String type, required String path}) {
    if (type == '_Directory') {
      return Directory(path);
    } else if (type == '_File') {
      return File(path);
    } else if (type == '_Link') {
      return Link(path);
    }
    throw 'Not the type from getFseType';
  }

  String checkNewPath(String? path) {
    assert(path != null);
    return path!;
  }

  String getStringType({required String path}) {
    // print('${path.lastIndexOf('/') == path.length} ${path.lastIndexOf('/')} ${path.length}');
    if (path.lastIndexOf('/') + 1 == path.length) {
      return '_Directory';
    } else if (path.lastIndexOf('/') != path.length) {
      return '_File';
    } else if (Link(path).existsSync()) {
      return '_Link';
    }
    throw 'Not the type from getTypeFromString';
  }

  Future<FileSystemEntity> primaryAction(
      {required PrimaryAction action, required String path}) {
    var type = getStringType(path: path);
    // print(type);
    switch (action) {
      case PrimaryAction.delete:
        return getFseType(type: type, path: path).delete();
      case PrimaryAction.create:
        return create(type: type, path: path);
    }
  }

  secondaryAction(
      {required SecondaryAction action,
      required String path,
      required String secondaryPath}) {
    var type = getStringType(path: path);
    var secondaryType = getStringType(path: secondaryPath);
    switch (action) {
      case SecondaryAction.read:
        return showFolderData(
            path: path, priorityFse: Fse(name: secondaryPath, type: secondaryType, path: path));
    }
  }

  Future<FileSystemEntity> create(
      {required String type, required String path}) {
    if (type == '_Directory') {
      return Directory(path).create();
    } else if (type == '_File') {
      return File(path).create();
    }
    // else if(type == '_Link') {
    //   Link(path).createSync(target)
    // }

    throw 'Not the type from createSync';
  }

  // copySync({required String type, required String path, required newPath}) {
  //   if (type == '_File') {
  //     File(path).copySync(newPath);
  //   }
  // }

  // moveSync({})
}
