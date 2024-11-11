// import 'dart:io';
// import 'package:context_menus/context_menus.dart';
// import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cardoteka/cardoteka.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/features/settings/settings.dart';
import 'package:tengo/features/settings/settings_cards.dart';
import 'package:tengo/features/file/bloc/file_bloc.dart';
import 'package:tengo/features/folder/bloc/folder_bloc.dart';
import 'package:tengo/features/file/repositories/file_repository.dart';
import 'package:tengo/features/folder/repositories/folder_repository.dart';
import 'package:tengo/features/models/fse_action.dart';
// import 'package:window_manager_plus/window_manager_plus.dart';

import 'features/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cardoteka.init();

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
                    FolderBloc(folderRepository: FolderRepository())
                      ..add(
                        const PrimaryActionHappened(
                          action: PrimaryAction.read,
                          path: './',
                        ),
                      ),
              ),
              BlocProvider(
                create: (context) =>
                    FileBloc(fileRepository: const FileRepository()),
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
                      borderRadius: SmoothBorderRadius(cornerRadius: 14))))),
          buttonTheme: ButtonThemeData(
              shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 14))),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(cornerRadius: 14))))),
          menuTheme: MenuThemeData(
              style: MenuStyle(
                  shape: WidgetStatePropertyAll(SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(cornerRadius: 14))))),
          popupMenuTheme: PopupMenuThemeData(
              shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 14)))),
    );
  }
}
