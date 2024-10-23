import 'dart:io';

// import 'package:tengo_simple/repositories/folder_page/folder_repository_interface.dart';
// import 'package:tengo_simple/repositories/folder_page/models/folder.dart';
import 'package:tengo_simple/repositories/fse/models/models.dart';

class FolderRepository {
  FolderRepository();
  @override
  Stream<FileSystemEntity> showFolderData({required String path}) {
    // folder = Folder();
    return Directory(path).list();
  }

  String toAbsolute({required String path}) {
    path = Directory(path).absolute.path;
    if (path.substring(path.length - 3, path.length) == '../') {
      path = path.substring(0, path.length - 3);
      path = path.substring(0, path.lastIndexOf('/'));
      path = path.substring(0, path.lastIndexOf('/')+1);
    } else if (path.substring(path.length - 2, path.length) == './') {
      path = path.substring(0, path.length - 2);
    }
    return path;
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
}
