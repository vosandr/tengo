import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo_viewer/features/file/bloc/file_bloc.dart';
import 'package:tengo_viewer/features/folder/widgets/widgets.dart';

import 'bloc/folder_bloc.dart';

class FolderWidget extends StatefulWidget {
  const FolderWidget({super.key});

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {
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
            return ContextMenuOverlay(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var fse = state.fseList[index];

                  return
                      // ContextMenuRegion(
                      //             contextMenu: FolderContextMenu(),
                      // child:
                      TextButton(
                    onPressed: () {
                      if (fse.type == '_Directory') {
                        // context
                        //     .read<FolderViewBloc>()
                        //     .add(FolderViewClearRequested());
                        context
                            .read<FolderBloc>()
                            .add(ShowFolder(path: fse.name));
                      } else if (fse.type == '_File') {
                        context
                            .read<FileBloc>()
                            .add(ShowFile(name: fse.name, path: fse.path));
                      }
                    },
                    style: const ButtonStyle(),
                    child: Text(fse.name.toString()),
                  );
                  // );
                },
                itemCount: state.fseList.length,
              ),
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
