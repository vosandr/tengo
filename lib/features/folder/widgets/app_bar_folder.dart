import 'dart:convert';

// import 'package:desktop_multi_window/desktop_multi_window.dart';
// import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cardoteka/cardoteka.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/features/settings/settings.dart';
import 'package:tengo/features/settings/settings_cards.dart';
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
  final TextEditingController _textEditingController = TextEditingController();
  // final FocusNode _focusNode = FocusNode();
  // String path = '';
  // @override
  // void didUpdateWidget(covariant FolderAppBar oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FolderBloc, FolderState>(
      listener: (context, state) {},
      builder: (context, state) {
        // path = state.path;
        return Column(children: [
          AppBar(
            title: TextField(
              onSubmitted: (value) {
                context.read<FolderBloc>().add(BooleanVarChanged(
                    booleanVar: BooleanVar.textFieldEnabled, value: true));
              },
              controller: _textEditingController
                ..value = TextEditingValue(
                    text: state.path,
                    selection:
                        TextSelection.collapsed(offset: state.path.length)),
              // autofocus: true,
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
                mainAxisAlignment: MainAxisAlignment.center,
                // direction: Axis.horizontal,
                children: [
                  // Expanded(
                  //     child: IconButton(
                  //         onPressed: () {},
                  //         icon: Icon(Icons.curtains_closed_outlined))),
                  Hider(
                    showWidget: IconButton(
                      // shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 14)),
                      onPressed: () {},

                      icon: Icon(Icons.add),
                    ),
                    hideWidget: SizedBox.shrink(),
                  ),
                  // Expanded(
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(Icons.push_pin),
                  //   ),
                  // ),
                  IconButton(
                      onPressed: () {
                        context.read<FolderBloc>().add(PrimaryActionHappened(
                            action: PrimaryAction.read, path: ''));
                      },
                      icon: Icon(Icons.refresh)),
                  IconButton(
                      onPressed: () {
                        context.read<FolderBloc>().add(
                            const PrimaryActionHappened(
                                action: PrimaryAction.read, path: '../'));
                      },
                      icon: const Icon(Icons.grid_3x3)),

                  IconButton(
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Settings()));
                      },
                      icon: Icon(Icons.settings)),
                ]),
          )
        ]);
      },
    );
  }
}
