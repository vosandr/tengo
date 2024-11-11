import 'package:cardoteka/cardoteka.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/features/settings/settings_cards.dart';
import 'package:tengo/features/file/bloc/file_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
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
                          context.read<FileBloc>().add(
                                RenameFile(
                                  name: state.name,
                                  newName: newName,
                                  path: state.path,
                                ),
                              );
                        },
                        controller: TextEditingController(text: state.name)),
                  )
                ],
              )),
          body: TextField(
            readOnly: !(settings.get(SettingsCards.isEditMode)),
            controller: TextEditingController(text: state.content),
            onChanged: (content) {
              context.read<FileBloc>().add(WriteFile(
                  name: state.name, content: content, path: state.path));
            },
            expands: true,
            maxLines: null,
            decoration: const InputDecoration(),
          ),
        );
      },
    );
  }
}

// class FruitColorizer extends TextEditingController {
//   final HighlightConfiguration configuration;
//   final Pattern pattern;

//   FruitColorizer(this.mapping)
//       : pattern =
//             RegExp(mapping.keys.map((key) => RegExp.escape(key)).join('|'));

//   FruitColorizer.fromColors(Map<String, Color> colorMap)
//       : this(colorMap
//             .map((text, color) => MapEntry(text, TextStyle(color: color))));

//   @override
//   TextSpan buildTextSpan(
//       {required BuildContext context,
//       TextStyle? style,
//       required bool withComposing}) {
//     List<InlineSpan> children = [];

//     text.splitMapJoin(
//       pattern,
//       onMatch: (Match match) {
//         children.add(
//             TextSpan(text: match[0], style: style?.merge(mapping[match[0]])));
//         return match[0] ?? '';
//       },
//       onNonMatch: (String text) {
//         children.add(TextSpan(text: text, style: style));
//         return text;
//       },
//     );
//     return TextSpan(style: style, children: children);
//   }
// }

// class HighlightConfiguration {
// }
