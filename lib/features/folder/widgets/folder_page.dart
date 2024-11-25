import 'package:cardoteka/cardoteka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo/features/models/fse.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/features/settings/settings_cards.dart';
import 'package:tengo/features/file/bloc/file_bloc.dart';
import 'package:tengo/features/folder/widgets/widgets.dart';
import 'package:tengo/features/models/fse_action.dart';

import '../bloc/folder_bloc.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({super.key});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  // bool enabledTextField = false;
  final settings = SettingsCardoteka(
      config: CardotekaConfig(
          name: 'settings',
          cards: SettingsCards.values,
          converters: SettingsCards.converters));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.copy(AppBar().preferredSize *
                3),
            child: const FolderAppBar()),
        body: BlocBuilder<FolderBloc, FolderState>(builder: (context, state) {
          if (state.status == FolderStatus.loading) {
            return const Center(child: LinearProgressIndicator());
          } else if (state.status != FolderStatus.success) {
            return const SizedBox.shrink();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                Fse fse = state.fseList[index];

                return FolderContextMenu(
                    disabled: !(settings.get(SettingsCards.isEditMode)),
                    fse: fse,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 9.0),
                            child: Text(
                              '$index.',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (fse.type == '_Directory') {
                                context
                                    .read<FolderBloc>()
                                    .add(PrimaryActionHappened(
                                      action: PrimaryAction.read,
                                      path: fse.name,
                                    ));
                              } else if (fse.type == '_File') {
                                context.read<FileBloc>().add(
                                    ShowFile(name: fse.name, path: state.path));
                              }
                            },
                            style: const ButtonStyle(),
                            child: Text(fse.name.toString()),
                          ),
                        ],
                      ),
                    ));
                // );
              },
              itemCount: state.fseList.length,
            );
          }
        }));
  }
}
