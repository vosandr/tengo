import 'dart:io';

// import 'package:tengo_simple/repositories/fse/types/folder/folder_repository.dart';

class FileRepository {
  FileRepository();
  late String _name;
  late String _path;
  late String _content;
  init({required String path, required String name}) {
    _name = name;
    _path = path;
  }

  String showFileData({String? path, String? name}) {
    _path = path ?? _path;
    _name = name ?? _name;
    _content = File(_path + _name).readAsStringSync();
    return _content;
  }

  Future<File> rename({required String newName}) {
    return File(_path + _name).rename(_path + newName);
  }

  write({required String content}) {
    _content = content;
    File(_path + _name).writeAsStringSync(_content);
  }
}
