import 'dart:io';

import 'package:cardoteka/cardoteka.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo/features/file/bloc/file_bloc.dart';
import 'package:tengo/features/file/highlight/md/link_text/links_repository.dart';
import 'package:tengo/features/folder/bloc/folder_bloc.dart';
import 'package:tengo/features/models/fse_action.dart';
import 'package:tengo/features/settings/settings_cards.dart';

enum LinkPattern {
  flag('[['),
  endFlag(']]'),
  ;

  const LinkPattern(this.value);
  final String value;
}

class LinkText extends SpecialText {
  LinkText(
      {this.style,
      this.start,
      this.index,
      required this.context,
      required this.path
      // required this.selection,
      })
      : super(LinkPattern.flag.value, LinkPattern.endFlag.value, style);
  final settings = SettingsCardoteka(
      config: CardotekaConfig(
          name: 'settings',
          cards: SettingsCards.values,
          converters: SettingsCards.converters));
  final int? start;
  final TextStyle? style;
  final int? index;
  final BuildContext context;
  final String path;
  String lastPath = '';
  // final TextSelection selection;
  String _getStringType({required String path}) {
    // print('${path.lastIndexOf(Platform.pathSeparator) == path.length} ${path.lastIndexOf(Platform.pathSeparator)} ${path.length}');
    if (path.lastIndexOf(settings.get(SettingsCards.pathSeparator)) + 1 ==
        path.length) {
      return '_Directory';
    } else if (path.lastIndexOf(settings.get(SettingsCards.pathSeparator)) !=
        path.length) {
      return '_File';
    }
    // else if (Link(path).existsSync()) {
    //   return '_Link';
    // }
    throw 'Not the type from getTypeFromString';
  }

  @override
  InlineSpan finishText() {
    // debugPrint('$index $selection');
    bool isHover = false;
    String name = toString().substring(2, toString().length - 2);
    // name =
        // LinksRepository(path: path, link: name, context: context).normalise();
    // debugPrint(selection.base.offset.toString());
    var type = _getStringType(path: name);
    TextStyle? style;
    if (type == '_File') {
      if (File(path + name).existsSync()) {
        style = TextStyle(
            color: Colors.deepPurple[800],
            decoration: TextDecoration.underline);
      } else {
        style = TextStyle(
            color: Colors.deepPurple[200],
            decoration: TextDecoration.underline);
      }
    } else if (type == '_Directory') {
      if (Directory(path + name).existsSync()) {
        style = TextStyle(
            color: Colors.deepPurple[800],
            decoration: TextDecoration.underline);
      } else {
        style = TextStyle(
            color: Colors.deepPurple[200],
            decoration: TextDecoration.underline);
      }
      // debugPrint(path + name);
    }
    return TextSpan(
      text: LinkPattern.flag.value,
      children: [
        TextSpan(
            style: style,
            text: name,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                var type = _getStringType(path: name);
                if (type == '_File') {
                  if (File(path + name).existsSync()) {
                    context
                        .read<FileBloc>()
                        .add(ShowFile(name: name, path: path));
                  } else {
                    context.read<FolderBloc>().add(PrimaryActionHappened(
                        action: PrimaryAction.create, path: name));
                  }
                }
                if (type == '_Directory') {
                  if (Directory(path + name).existsSync()) {
                    context.read<FolderBloc>().add(ReadingLinksHappened(
                          name: name,
                          path: path,
                        ));
                  } else {
                    context.read<FolderBloc>().add(PrimaryActionHappened(
                        action: PrimaryAction.create, path: name));
                    // context.read<FolderBloc>().add(PrimaryActionHappened(
                    //     action: PrimaryAction.read, path: path));
                  }
                  // debugPrint(path + name);
                }
              },
            onEnter: (event) {
              if (isHover == false) {
                isHover = true;
                // debugPrint(isHover.toString());
              }
            },
            onExit: (_) {
              if (isHover == true) {
                isHover = false;
                // debugPrint(isHover.toString());
              }
            }),
        TextSpan(text: LinkPattern.endFlag.value)
      ],
    );
    // if(){

    // }
    // // TODO: implement finishText
    // throw UnimplementedError();
  }
}

// class LinkUtil {
//   Link
// }
