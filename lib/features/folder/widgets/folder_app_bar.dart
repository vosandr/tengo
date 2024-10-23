import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo_simple/features/folder/bloc/folder_bloc.dart';
import 'package:tengo_simple/repositories/folder_page/folder_repository.dart';

class FolderAppBar extends StatelessWidget {
  const FolderAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderBloc, FolderState>(
      builder: (context, state) {
        return Column(children: [
          AppBar(title: 
              TextField(
              
                controller: TextEditingController(text: state.path),
              )),
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
                  Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.curtains_closed_outlined))),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          context
                              .read<FolderBloc>()
                              .add(CreateFolder());
                        },
                        icon: Icon(Icons.add)),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.push_pin),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          context
                              .read<FolderBloc>()
                              .add(HideFolder());
                          context.read<FolderBloc>().add(
                              ShowFolder(path: '../'));
                        },
                        icon: Icon(Icons.grid_3x3)),
                  ),
                  Expanded(
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.refresh))),
                  Expanded(
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.settings)))
                ]),
          )
        ]);
      },
    );
  }
}