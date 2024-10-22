import 'dart:io';

import 'package:tengo_simple/repositories/fse/models/models.dart';

export 'models/models.dart';

class FseRepository {
  FseRepository({required this.fse});
  Fse fse;
  // determineType(String path) {
  //   if (fse.type == '_Directory') {
  //     return Directory(path);
  //   } else if (fse.type == '_File') {
  //     return File(path);
  //   } else if (fse.type == '_Link') {
  //     return Link(path);
  //   }
  // }
  FileSystemEntity getFseType() {
    if (fse.type == '_Directory') {
      return Directory(fse.path);
    } else if (fse.type == '_File') {
      return File(fse.path);
    } else if (fse.type == '_Link') {
      return Link(fse.path);
    } else {
      throw 'Wrong Type';
    }
  }

  getFses() {
    if (fse.type == '_Directory') {
    Directory(fse.path).list();
    } else if (fse.type == '_File') {
      return File(fse.path).readAsBytes();
    } else if (fse.type == '_Link') {
      return Link(fse.path).resolveSymbolicLinks();
    }
  }

  create() {
    if (fse.type == '_Directory') {
      return Directory(fse.path).create();
    } else if (fse.type == '_File') {
      return File(fse.path).create();
    }
  }

  Future<Link> createLink(String newPath) {
    if (fse.type == '_Link') {
      return Link(fse.name).create(newPath);
    } else {
      throw 'Wrong type';
    }
  }

  Future<FileSystemEntity> delete() {
    return getFseType().delete();
  }

  Future<FileSystemEntity> rename(String newPath) {
    return getFseType().rename(newPath);
  }

  Future<bool> exists() {
    return getFseType().exists();
  }

  Stream<FileSystemEvent> stat() {
    return getFseType().watch();
  }

  Stream<FileSystemEvent> watch() {
    return getFseType().watch();
  }
}
