import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo/features/file/bloc/file_bloc.dart';
import 'package:tengo/features/folder/bloc/folder_bloc.dart';

class LinksRepository {
  LinksRepository(
      {required String path,
      required link,
      required this.context,
      required this.selection})
      : _path = path,
        _name = link;
  String _path;
  BuildContext context;
  TextSelection selection;
  String _name;
  String _getStringType() {
    // print('${path.lastIndexOf(Platform.pathSeparator) == path.length} ${path.lastIndexOf(Platform.pathSeparator)} ${path.length}');
    if (_name.lastIndexOf(Platform.pathSeparator) + 1 == _name.length) {
      return '_Directory';
    } else if (_name.lastIndexOf(Platform.pathSeparator) != _name.length) {
      return '_File';
    }
    // else if (Link(path).existsSync()) {
    //   return '_Link';
    // }
    throw 'Not the type from getTypeFromString';
  }

  _normalise() {
    if (_name.startsWith('.' + Platform.pathSeparator)) {
      _name = _name.substring(2);
    } else if (_name.startsWith('..' + Platform.pathSeparator)) {
      _name = _name.substring(3);
      _path = _path.substring(
          0, _path.length - 1 - _path.lastIndexOf(Platform.pathSeparator));
    }

    if (_name.startsWith(r'#\d' + Platform.pathSeparator)) {
      var jumpNumber = _name.indexOf('d');
      _name = _name.substring(2);
      for (var i = 0; i < jumpNumber; i++) {
        _path = _path.substring(
            0, _path.length - 1 - _path.lastIndexOf(Platform.pathSeparator));
      }
    }
  }

  onTapLink() {
    _normalise();
    var type = _getStringType();
    if (type == '_File') {
      if (File(_path + _name).existsSync()) {
        context.read<FileBloc>().add(ShowFile(name: _name, path: _path));
      }
    }
    if (type == '_Directory') {
      if (Directory(_path + _name).existsSync()) {
        context.read<FolderBloc>().add(ReadingLinksHappened(
              name: _name,
              path: _path,
            ));
      }
      debugPrint(_path + _name);
    }
  }
}
