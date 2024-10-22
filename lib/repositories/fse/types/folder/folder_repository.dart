import 'dart:io';

class FolderRepository {
  FolderRepository();

  Stream<FileSystemEntity> getFse(String path) {
    return Directory(path).list();

  }
}
