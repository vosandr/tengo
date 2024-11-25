import 'package:cardoteka/cardoteka.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo/features/file/highlight/highlight_span_builder.dart';
import 'package:tengo/features/file/repositories/highlighter.dart';
import 'package:tengo/features/file/highlight/md/link_text/links_repository.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/features/settings/settings_cards.dart';
import 'package:tengo/features/file/bloc/file_bloc.dart';
import '../repositories/flr_change/rendering/editable.dart';

class FileContentPage extends StatefulWidget {
  const FileContentPage({super.key});

  @override
  State<FileContentPage> createState() => _FileContentPageState();
}

class _FileContentPageState extends State<FileContentPage> {
  final settings = SettingsCardoteka(
      config: CardotekaConfig(
          name: 'settings',
          cards: SettingsCards.values,
          converters: SettingsCards.converters));
  final TextSelection _textSelection =
      TextSelection.fromPosition(const TextPosition(offset: -1));
  final contentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final _selection = contentTextController.selection;
    // print(_selection.base);
    return BlocBuilder<FileBloc, FileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Column(
                children: [
                  AppBar(
                    title: TextField(
                        readOnly: !(settings.get(SettingsCards.isEditMode)),
                        onSubmitted: (newName) {
                          if (state.path != '') {
                            context.read<FileBloc>().add(
                                  RenameFile(
                                    name: state.name,
                                    newName: newName,
                                    path: state.path,
                                  ),
                                );
                          }
                        },
                        controller: TextEditingController(text: state.name)),
                  )
                ],
              )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ExtendedTextField(
              
              specialTextSpanBuilder: HighlightSpanBuilder(
                  context: context,
                  selection: contentTextController.selection,
                  path: state.path),
              // inputFormatters: [
              //   FilteringTextInputFormatter(
              //       settings.get(SettingsCards.patternFromLinks),
              //       allow: true)
              // ],
              readOnly: !(settings.get(SettingsCards.isEditMode)),
              controller: TextEditingController(text: state.content),
              // ContentTextEditingController(
              //     text: state.content,
              //     settings: settings,
              //     style: TextStyle(),
              //     context: context,
              //     path: state.path)
              //   ..selection,
              // ..addListener(() {
              //   contentTextController.selection;
              // }),
              onChanged: (content) {
                // print(state.content);
                if (state.path != '') {
                  context.read<FileBloc>().add(WriteFile(
                      name: state.name, content: content, path: state.path));
                }
              },
              
              expands: true,
              maxLines: null,

              decoration: const InputDecoration(),
            ),
          ),
        );
      },
    );
  }
}
