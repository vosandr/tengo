import 'dart:io';

// import 'package:tengo_simple/repositories/fse/types/folder/folder_repository.dart';

class FileRepository {
  const FileRepository();

  Stream<List<int>> showFileData(String str) {
    return File(str).openRead();
  }
}
