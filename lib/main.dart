import 'dart:io';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo_simple/features/folder/bloc/folder_view_bloc.dart';
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
        children: [
          ResizableChild(
              child: BlocProvider(
                create: (context) =>
                    FolderViewBloc(folderRepository: FolderRepository())..add(FolderViewSubscriptionRequested()),
                child: FolderListView(),
              ),
              size: ResizableSize.ratio(1 / 4)),
          ResizableChild(child: FileContentPage()),
        ],
        direction: Axis.horizontal,
      )),
      theme: ThemeData(
          buttonTheme: ButtonThemeData(
              shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 16)))),
    );
  }
}
