import 'dart:io';

import 'package:tengo_simple/repositories/folder_page/folder_repository_interface.dart';
import 'package:tengo_simple/repositories/folder_page/models/folder.dart';
import 'package:tengo_simple/repositories/fse/models/models.dart';

class FolderRepository implements FolderRepositoryI {
  FolderRepository({this.fseList});
  late Folder folder;
  late List<Fse>? fseList;
  @override
  Stream<FileSystemEntity> getFseListInFolder({required String path}) {
    // folder = Folder();
    return Directory(path).list();
  }

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
