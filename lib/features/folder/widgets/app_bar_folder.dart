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
  late final TextEditingController _pathTextController;
  final TextEditingController _createEditingController =
      TextEditingController();
  late final ScrollController _pathScrollController;
  // final FocusNode _focusNode = FocusNode();
  // String path = '';
  // @override
  // void didUpdateWidget(covariant FolderAppBar oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  final bool _firstCalled = false;
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   _textEditingController.addListener(() {_textEditingController.});
  // }
  @override
  void initState() {
    super.initState();
    _pathTextController = TextEditingController()
      ..addListener(() {
        _scrollToEnd();
      });
    _pathScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pathTextController.dispose();
    _pathScrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    Future.delayed(Duration.zero, () {
      if (_pathScrollController.hasClients &&
          _pathScrollController.position.maxScrollExtent !=
              _pathScrollController.offset) {
        _pathScrollController.animateTo(
            _pathScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 1),
            curve: Curves.linear);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FolderBloc, FolderState>(
      listener: (context, state) {},
      builder: (context, state) {
        // path = state.path;
        return Column(children: [
          AppBar(
            title: TextField(
              scrollController: _pathScrollController,
              onSubmitted: (value) {
                context.read<FolderBloc>().add(ChangePathEvent(path: value));
              },
              // onSubmitted: (value) {},
              controller: _pathTextController..text = state.path,
            ),
          ),
          Hider(
            showWidget: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 15),
              child: AppBar(
                // bottom: PreferredSize(preferredSize: Size(1, 1), child: SizedBox()),
                // leading: Padding(
                // padding: const EdgeInsets.all(8.0),
                titleSpacing: 7,
                leadingWidth: 30,
                leading:
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8),
                    //   child:
                    // Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // children: [
                    const Icon(Icons.add),

                title: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: TextField(
                    onSubmitted: (value) {
                      _createEditingController.text = '';
                      context.read<FolderBloc>().add(
                            PrimaryActionHappened(
                              action: PrimaryAction.create,
                              path: value,
                            ),
                          );
                      // context.read<FolderBloc>().add(PrimaryActionHappened(
                      //     action: PrimaryAction.read, path: value));
                    },
                    controller: _createEditingController,
                  ),
                ),
              ),
            ),
            hideWidget: const SizedBox.shrink(),
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
                  // Hider(
                  //   showWidget: IconButton(
                  //     // shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 14)),
                  //     onPressed: () {
                  //       context.read<FolderBloc>().add(BooleanVarChanged(
                  //           booleanVar: BooleanVar.textFieldEnabled,
                  //           value: true));
                  //     },

                  //     icon: Icon(Icons.add),
                  //   ),
                  //   hideWidget: SizedBox.shrink(),
                  // ),
                  // Expanded(
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(Icons.push_pin),
                  //   ),
                  // ),
                  IconButton(
                      onPressed: () {
                        context.read<FolderBloc>().add(
                            const PrimaryActionHappened(
                                action: PrimaryAction.read, path: ''));
                      },
                      icon: const Icon(Icons.refresh)),

                  IconButton(
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Settings()));
                      },
                      icon: const Icon(Icons.settings)),
                  IconButton(
                      onPressed: () {
                        context.read<FolderBloc>().add(
                            const PrimaryActionHappened(
                                action: PrimaryAction.read, path: '../'));
                      },
                      icon: const Icon(Icons.grid_3x3)),
                ]),
          ),
        ]);
      },
    );
  }
}
