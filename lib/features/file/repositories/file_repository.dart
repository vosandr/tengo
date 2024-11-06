import 'dart:io';

// import 'package:tengo_simple/repositories/fse/types/folder/folder_repository.dart';

class FileRepository {
  const FileRepository();

  Stream<List<int>> showFileData(String str) {
    return File(str).openRead();
  }

  Future<File> rename(
      {required String path, required String name, required String newName}) {
    return File(path + name).rename(path + newName);
  }

  write({required String name, required String content, required String path}) {
    File(path+name).writeAsStringSync(content);
  }
}
