import 'dart:async';
import 'dart:io';

import 'package:cardoteka/cardoteka.dart';
import 'package:tengo/features/models/fse_action.dart';
import 'package:tengo/features/models/fse.dart';
import 'package:tengo/features/settings/settings_cards.dart';
import 'folder_links_repository.dart';

class FolderRepository {
  FolderRepository({required this.currentPath});
  // final String _path='';
  final settings = SettingsCardoteka(
      config: CardotekaConfig(
          name: 'settings',
          cards: SettingsCards.values,
          converters: SettingsCards.converters));
  String currentPath;
  late List<Fse> _fseList;
  late Fse _currentFolderFse;

  List<Fse> showFolderData() {
    // folder = Folder();
    List<Fse> linkedFseList = FolderLinksRepository(
      mainPriorityFse: Fse(
          name: settings.get(SettingsCards.priorityFseName),
          type: getStringType(
            path: settings.get(SettingsCards.priorityFseName),
          ),
          path: currentPath),
      pattern: RegExp(
        settings.get(SettingsCards.patternFromLinks),
      ),
    ).showPriorityFseList();

    List<Fse> sortingFseList = [];
    // print(path);
    var dataList = Directory(currentPath).listSync();

    // print('$priorityPath ${fse.name}');
    for (var data in dataList) {
      _currentFolderFse =
          Fse(name: data.path, type: data.runtimeType.toString());
      format();
      if (linkedFseList
          .every((linkedFse) => linkedFse.name != _currentFolderFse.name)) {
        sortingFseList.add(_currentFolderFse);
      }
    }
    return linkedFseList + sort(sortingFseList);
  }

  List<Fse> sort(List<Fse> sortingFseList) {
    sortingFseList.sort((a, b) {
      if (a.name.startsWith('.') && b.name.startsWith('.')) {
        return a.name.substring(1).compareTo(b.name.toLowerCase().substring(1));
      } else if (a.name.startsWith('.')) {
        return a.name.substring(1).compareTo(b.name.toLowerCase());
      } else if (b.name.startsWith('.')) {
        return a.name.compareTo(b.name.toLowerCase().substring(1));
      }
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return sortingFseList;
  }

  format() {
    _currentFolderFse.name = _currentFolderFse.name.substring(
        _currentFolderFse.name.lastIndexOf(Platform.pathSeparator) + 1);
    if (_currentFolderFse.type == '_Directory') {
      _currentFolderFse.name += Platform.pathSeparator;
    }
    // return _currentFolderFse;
  }

  String toAbsoluteFolder({required String path}) {
    path = Directory(path).absolute.path;
    if (path.substring(path.length - 3, path.length) == '../') {
      path = path.substring(0, path.length - 3);
      path = path.substring(0, path.lastIndexOf(Platform.pathSeparator));
      path = path.substring(0, path.lastIndexOf(Platform.pathSeparator) + 1);
    } else if (path.substring(path.length - 2, path.length) == './') {
      path = path.substring(0, path.length - 2);
    }

    return path;
  }

  toParentFolder({required String path}) {
    // print(path);
    // print('${path.length.toString()} ${path.lastIndexOf(Platform.pathSeparator)}');
    if (path.length == path.lastIndexOf(Platform.pathSeparator) + 1) {
      // print(path);
      path = path.substring(0, path.length - 1);
    }
    // print(path);
    path = path.substring(0, path.lastIndexOf(Platform.pathSeparator) + 1);
    // print(path);
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
    // print('${path.lastIndexOf(Platform.pathSeparator) == path.length} ${path.lastIndexOf(Platform.pathSeparator)} ${path.length}');
    if (path.lastIndexOf(Platform.pathSeparator) + 1 == path.length) {
      return '_Directory';
    } else if (path.lastIndexOf(Platform.pathSeparator) != path.length) {
      return '_File';
    }
    // else if (Link(path).existsSync()) {
    //   return '_Link';
    // }
    throw 'Not the type from getTypeFromString';
  }

  List<Fse> primaryAction(
      {required PrimaryAction action, required String path}) {
    var type = getStringType(path: path);
    var ioFse = getFseType(type: type, path: path);
    // print(parentIoFse);
    // print(type);
    switch (action) {
      case PrimaryAction.read:
        currentPath = path;
      case PrimaryAction.delete:
        ioFse.delete();
        currentPath = ioFse.parent.path;
      case PrimaryAction.create:
        create(type: type, path: path);
        currentPath = ioFse.parent.path;
    }
    return showFolderData();
  }

  // secondaryAction(
  //     {required SecondaryAction action,
  //     required String path,
  //     required String secondaryPath}) {
  //   // var type = getStringType(path: path);
  //   // var secondaryType = getStringType(path: secondaryPath);
  //   switch (action) {
  //     case SecondaryAction.readLink:
  //       return FolderLi(
  //           path: path,);
  //   }
  // }

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
