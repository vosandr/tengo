// import 'dart:io';
// import 'package:context_menus/context_menus.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo_viewer_prioritising_files/features/file/bloc/file_bloc.dart';
import 'package:tengo_viewer_prioritising_files/features/folder/bloc/folder_bloc.dart';
import 'package:tengo_viewer_prioritising_files/repositories/fse/file_repository.dart';
import 'package:tengo_viewer_prioritising_files/repositories/fse/folder_repository.dart';

import 'features/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return Scaffold(
            body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    FolderBloc(folderRepository: FolderRepository())..add(const ShowFolder()),
              ),
              BlocProvider(
                create: (context) => FileBloc(fileRepository: const FileRepository()),
              ),
            ],
            child: const ResizableContainer(
              divider: ResizableDivider(thickness: 2),
              children: [
                ResizableChild(
                  child: FolderWidget(),
                  size: ResizableSize.ratio(1 / 4),
                ),
                ResizableChild(
                  child: FileContentPage(),
                ),
              ],
              direction: Axis.horizontal,
            ),
          ),
        );
      }),
      theme: ThemeData(
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(cornerRadius: 16))))),
        buttonTheme: ButtonThemeData(
            shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(cornerRadius: 16))),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(cornerRadius: 12))))),
      ),
    );
  }
}
