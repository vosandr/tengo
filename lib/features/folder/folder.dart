import 'package:cardoteka/cardoteka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo/features/models/fse.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/features/settings/settings_cards.dart';
import 'package:tengo/features/file/bloc/file_bloc.dart';
import 'package:tengo/features/folder/widgets/widgets.dart';
import 'package:tengo/features/models/fse_action.dart';

import 'bloc/folder_bloc.dart';

class FolderWidget extends StatefulWidget {
  const FolderWidget({super.key});

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {
  bool enabledTextField = false;
  final settings = SettingsCardoteka(
      config: CardotekaConfig(
          name: 'settings',
          cards: SettingsCards.values,
          converters: SettingsCards.converters));
  @override
  Widget build(BuildContext context) {
    // bool isScreenWide = MediaQuery.sizeOf(context).width >= kmi;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.copy(AppBar().preferredSize * 2),
            child: const FolderAppBar()),
        body: BlocBuilder<FolderBloc, FolderState>(builder: (context, state) {
          if (state.status == FolderStatus.loading) {
            return const Center(child: LinearProgressIndicator());
          } else if (state.status != FolderStatus.success) {
            return const SizedBox();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                Widget item;
                int fseIndex = index;
                if (state.textFieldEnabled == true && index == 0) {
                  item = TextField(
                    onTapOutside: (pointer) {
                      context.read<FolderBloc>().add(BooleanVarChanged(
                          booleanVar: BooleanVar.textFieldEnabled,
                          value: false));
                    },
                    onSubmitted: (value) {
                      context.read<FolderBloc>().add(BooleanVarChanged(
                          booleanVar: BooleanVar.textFieldEnabled,
                          value: false));
                      context.read<FolderBloc>().add(
                            PrimaryActionHappened(
                              action: PrimaryAction.create,
                              path: state.path + value,
                            ),
                          );
                    },
                    autofocus: true,
                  );
                  fseIndex = index - 1;
                } else {
                  Fse fse = state.fseList[fseIndex];
                  item = FolderContextMenu(
                      disabled: !(settings.get(SettingsCards.isEditMode)),
                      fse: fse,
                      // menuController: _menuController,
                      child: TextButton(
                        onPressed: () {
                          if (fse.type == '_Directory') {
                            // context
                            //     .read<FolderViewBloc>()
                            //     .add(FolderViewClearRequested());
                            context
                                .read<FolderBloc>()
                                .add(PrimaryActionHappened(
                                  action: PrimaryAction.read,
                                  path: fse.name,
                                ));
                          } else if (fse.type == '_File') {
                            context
                                .read<FileBloc>()
                                .add(ShowFile(name: fse.name, path: fse.path));
                          }
                        },
                        style: const ButtonStyle(),
                        child: Text(fse.name.toString()),
                      ));
                  // );
                }
                return item;
              },
              itemCount: enabledTextField
                  ? state.fseList.length + 1
                  : state.fseList.length,
            );
          }
        }));

    // return ListView.builder(
    //     itemCount: state.fses,
    //     // itemCount: fses.length,
    //     // childrenDelegate: SliverChildBuilderDelegate(
    //     itemBuilder: (context, index) => state

    //     );
  }
}
