import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo_viewer_prioritising_files/features/file/bloc/file_bloc.dart';
import 'package:tengo_viewer_prioritising_files/features/folder/bloc/folder_bloc.dart';

// class FolderAppBar extends StatefulWidget {
//   const FolderAppBar({
//     super.key,
//   });

//   @override
//   State<FolderAppBar> createState() => _FolderAppBarState();
// }

class FolderAppBar extends StatelessWidget {
  const FolderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderBloc, FolderState>(
      builder: (context, state) {
        return Column(children: [
          AppBar(
            title: TextField(readOnly: true, controller: TextEditingController(text: state.path)
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
                  // Expanded(
                  //   child: IconButton(
                  //       onPressed: () {
                  //         context
                  //             .read<FolderBloc>()
                  //             .add(CreateFolder());
                  //       },
                  //       icon: Icon(Icons.add)),
                  // ),
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
                                .add(ShowFolder(path: ''));
                          },
                          icon: Icon(Icons.refresh))),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          context
                              .read<FolderBloc>()
                              .add(const ShowFolder(path: '../'));
                        },
                        icon: const Icon(Icons.grid_3x3)),
                  ),
                  
                  // Expanded(
                  //     child: IconButton(
                  //         onPressed: () {}, icon: Icon(Icons.settings)))
                ]),
          )
        ]);
      },
    );
  }
}
