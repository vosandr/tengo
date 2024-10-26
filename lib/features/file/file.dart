import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo_viewer_prioritising_files/features/file/bloc/file_bloc.dart';

class FileContentPage extends StatelessWidget {
  const FileContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileBloc, FileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56 * 2),
              child: Column(
                children: [
                  AppBar(
                    title: TextField(
                      readOnly: true,
                      controller: TextEditingController(text: state.name)),
                  )
                ],
              )),
          body: TextField(
            readOnly: true,
            // readOnly: 'hasFile' != false ? false : true,
            controller: TextEditingController(text: state.content),
            onChanged: (string) {

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
