import 'dart:convert';

// import 'package:desktop_multi_window/desktop_multi_window.dart';
// import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/another_windows/settings.dart';
import 'package:tengo/another_windows/settings_model.dart';
// import 'package:tengo/another_windows/models/window_args.dart';
import 'package:tengo/features/file/bloc/file_bloc.dart';
import 'package:tengo/features/folder/bloc/folder_bloc.dart';
import 'package:tengo/main.dart';
import 'package:tengo/features/models/fse_action.dart';
import 'package:tengo/widgets/context_menu.dart';
import 'package:tengo/widgets/hider.dart';
// import 'package:window_manager_plus/window_manager_plus.dart';

// class FolderAppBar extends StatefulWidget {
//   const FolderAppBar({
//     super.key,
//   });

//   @override
//   State<FolderAppBar> createState() => _FolderAppBarState();
// }

class FolderAppBar extends StatefulWidget {
  const FolderAppBar({super.key});

  @override
  State<FolderAppBar> createState() => _FolderAppBarState();
}

class _FolderAppBarState extends State<FolderAppBar> {
  // final TextEditingController _textEditingController = TextEditingController();
  final MenuController _menuController = MenuController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderBloc, FolderState>(
      builder: (context, state) {
        return Column(children: [
          AppBar(
            title: TextField(
                // readOnly: !(SettingsModel().editingMode),
                onSubmitted: (value) {},
                controller: TextEditingController(text: state.path)
                // ..value = TextEditingValue(
                //     composing: TextRange.collapsed(state.path.length),
                //     text: state.path,
                //     selection:
                //         TextSelection.collapsed(offset: state.path.length)),
                ),
          ),
          AppBar(
            // clipBehavior: Clip.antiAlias,
            // toolbarHeight: 276,
            // leadingWidth: 100,
            leadingWidth: MediaQuery.of(context).size.width,
            // automaticallyImplyLeading: false,
            // title: TextFormField(
            //     initialValue: 'There is a weird folder name here'),
            leading: Row(

                // direction: Axis.horizontal,
                children: [
                  // Expanded(
                  //     child: IconButton(
                  //         onPressed: () {},
                  //         icon: Icon(Icons.curtains_closed_outlined))),
                  Hider(
                    showWidget: Expanded(
                        child: ContextMenu(
                      disabled: false,
                      menuMode: ContextMenuMode.primaryKey,
                      menuChildren: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            width: 100,
                            child: TextField(
                              onSubmitted: (text) {
                                context.read<FolderBloc>().add(
                                    PrimaryActionHappened(
                                        action: PrimaryAction.create,
                                        path: state.path+text));
                                // context
                                //     .read<FolderBloc>()
                                //     .add(ShowFolder(path: state.path));
                              },
                              style: TextStyle(),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                // isDense: true,
                              ),
                            ))
                      ],
                      child: Container(
                        child: IconButton(
                          // shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 14)),
                          onPressed: () {
                            // Not Using
                          },

                          icon: Icon(Icons.add),
                        ),
                      ),
                    )

                        /* GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          if (_menuController.isOpen) {
                            _menuController.close();
                            return;
                          }
                          _menuController.open(position: details.localPosition);
                        },
                        child: MenuAnchor(
                          style: MenuStyle(
                              shape: WidgetStatePropertyAll(SmoothRectangleBorder(
                                  borderRadius:
                                      SmoothBorderRadius(cornerRadius: 6)))),
                          controller: _menuController,
                          menuChildren: [
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                width: 100,
                                child: TextField(
                                  onSubmitted: (text) {
                                    context.read<FolderBloc>().add(
                                        OnePathActionHappened(
                                            action: OnePathAction.create,
                                            path: text));
                                  },
                                  style: TextStyle(),
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    // isDense: true,
                                  ),
                                ))
                          ],
                          child: 
                          IconButton(
                            // shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 14)),
                            onPressed: () {
                              // Not Using
                            },
                    
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ), */
                        ),
                    hideWidget: SizedBox.shrink(),
                  ),
                  // Expanded(
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(Icons.push_pin),
                  //   ),
                  // ),
                  Expanded(
                      child: IconButton(
                          onPressed: () {
                            context
                                .read<FolderBloc>()
                                .add(SecondaryActionHappened(action: SecondaryAction.read, path: '', secondaryPath: '00.md'));
                          },
                          icon: Icon(Icons.refresh))),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          context
                              .read<FolderBloc>()
                              .add(const SecondaryActionHappened(action: SecondaryAction.read, path: '../', secondaryPath: '00.md'));
                        },
                        icon: const Icon(Icons.grid_3x3)),
                  ),

                  Expanded(
                      child: IconButton(
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Settings()));
                          },
                          icon: Icon(Icons.settings))),
                ]),
          )
        ]);
      },
    );
  }
}
