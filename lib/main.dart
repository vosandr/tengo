import 'dart:io';
import 'package:context_menus/context_menus.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo_simple/features/file/bloc/file_bloc.dart';
import 'package:tengo_simple/features/folder/bloc/folder_bloc.dart';
import 'package:tengo_simple/repositories/folder_page/folder_repository.dart';

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
      home: Scaffold(
          body: ResizableContainer(
            divider: ResizableDivider(thickness: 2),
        children: [
          ResizableChild(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        FolderBloc(folderRepository: FolderRepository())
                          ..add(ShowFolder()),
                  ),
                  BlocProvider(
                    create: (context) => FileBloc(),
                  ),
                ],
                child: FolderWidget(),
              ),
              size: ResizableSize.ratio(1 / 4)),
          ResizableChild(
              child: BlocProvider(
            create: (context) => FileBloc(),
            child: FileContentPage(),
          )),
        ],
        direction: Axis.horizontal,
      )),
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
