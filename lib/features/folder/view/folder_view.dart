import 'dart:io';

import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tengo_simple/features/folder/folder_path.dart';
import 'package:tengo_simple/repositories/folder_page/folder_repository.dart';

import '../bloc/folder_view_bloc.dart';

// class FolderListPage extends StatelessWidget {
//   FolderListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) =>
//             FolderViewBloc(folderRepository: FolderRepository()));
//   }
// }

class FolderListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(56 * 2),
            child: Column(children: [
              AppBar(title: TextFormField(initialValue: 'Path')),
              AppBar(
                title: TextFormField(
                    initialValue: 'There is a weird folder name here'),
                actions: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<FolderViewBloc>()
                            .add(FolderViewCreateOccured());
                      },
                      icon: Icon(Icons.add)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.push_pin),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<FolderViewBloc>()
                            .add(FolderViewSubscriptionRequested(path: '../'));
                      },
                      icon: Icon(Icons.grid_3x3)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings))
                ],
              )
            ])),
        body: BlocBuilder<FolderViewBloc, FolderViewState>(
            builder: (context, state) {
          if (state.status == FolderViewLoadingStatus.loading) {
            return const Center(child: LinearProgressIndicator());
          } else if (state.status != FolderViewLoadingStatus.success) {
            return const SizedBox();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => ContextMenuRegion(
                contextMenu: GenericContextMenu(buttonConfigs: [
                  ContextMenuButtonConfig(
                    '',
                    onPressed: () {},
                    icon: Icon(Icons.drive_file_rename_outline),
                  ),
                  ContextMenuButtonConfig(
                    '',
                    onPressed: () {},
                    icon: Icon(Icons.copy),
                  ),
                  ContextMenuButtonConfig(
                    '',
                    onPressed: () {},
                    icon: Icon(Icons.move_down),
                  ),
                  ContextMenuButtonConfig(
                    '',
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                  ),
                ]),
                child: TextButton(
                  child: Text(state.fseList[index].name.toString()),
                  onPressed: () {
                    context.read<FolderViewBloc>().add(
                        FolderViewSubscriptionRequested(path: state.fseList[index].name));
                  },
                  style: ButtonStyle(),
                ),
              ),
              itemCount: state.fseList.length,
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
