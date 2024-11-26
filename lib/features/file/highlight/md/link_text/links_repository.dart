import 'dart:io';

import 'package:cardoteka/cardoteka.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo/features/file/bloc/file_bloc.dart';
import 'package:tengo/features/folder/bloc/folder_bloc.dart';
import 'package:tengo/features/models/fse.dart';
import 'package:tengo/features/settings/settings_cards.dart';

class LinksRepository {
  LinksRepository({
    required String path,
    required name,
    required this.context,
    // required this.selection,
  })  : _path = path,
        _name = name;
  String _path;
  BuildContext context;
  // TextSelection selection;
  String _name;
  final settings = SettingsCardoteka(
      config: CardotekaConfig(
          name: 'settings',
          cards: SettingsCards.values,
          converters: SettingsCards.converters));
  String _getStringType() {
    // print('${path.lastIndexOf(Platform.pathSeparator) == path.length} ${path.lastIndexOf(Platform.pathSeparator)} ${path.length}');
    if (_name.lastIndexOf(settings.get(SettingsCards.pathSeparator)) + 1 ==
        _name.length) {
      return '_Directory';
    } else if (_name.lastIndexOf(settings.get(SettingsCards.pathSeparator)) !=
        _name.length) {
      return '_File';
    }
    // else if (Link(path).existsSync()) {
    //   return '_Link';
    // }
    throw 'Not the type from getTypeFromString';
  }

  _toParentFolder() {
    _path = _path.substring(
        0,
        _path
                .substring(0, _path.length - 2)
                .lastIndexOf(settings.get(SettingsCards.pathSeparator)) +
            1);
  }

  normalise() {
    if (_name.startsWith('.' + settings.get(SettingsCards.pathSeparator))) {
      _name = _name.substring(2);
    } else if (_name
        .startsWith('..' + settings.get(SettingsCards.pathSeparator))) {
      _name = _name.substring(3);
      _toParentFolder();
    }
    if (_name.startsWith('#' + settings.get(SettingsCards.pathSeparator))) {
      _name = _name.substring(2);
      _toParentFolder();
      // debugPrint(_path);
    }
    if (_name.startsWith('##' + settings.get(SettingsCards.pathSeparator))) {
      _name = _name.substring(3);
      _toParentFolder();
      _toParentFolder();
    }
    if (_name.startsWith(r'#\d' + settings.get(SettingsCards.pathSeparator))) {
      var jumpNumber = _name.indexOf('d');
      _name = _name.substring(2);
      for (var i = 0; i < jumpNumber; i++) {
        _toParentFolder();
      }
    }
    // debugPrint(_path);
    return Fse(name: _name, type: _getStringType(), path: _path);
  }
}
