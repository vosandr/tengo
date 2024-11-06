import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/another_windows/settings_model.dart';
import 'package:tengo/features/file/bloc/file_bloc.dart';

class FileContentPage extends StatelessWidget {
  const FileContentPage({super.key});

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
                        readOnly: !(SettingsModel().editingMode),
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
            readOnly: !(SettingsModel().editingMode),
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
