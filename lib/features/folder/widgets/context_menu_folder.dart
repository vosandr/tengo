import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    hide SubmenuButton, MenuController, MenuAnchor, MenuItemButton;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo/features/folder/bloc/folder_bloc.dart';
import 'package:tengo/main.dart';
import 'package:tengo/open_source/menu_anchor.dart';
import 'package:tengo/features/models/fse.dart';
import 'package:tengo/features/models/fse_action.dart';
import 'package:tengo/widgets/context_menu.dart';

class FolderContextMenu extends StatelessWidget {
  const FolderContextMenu(
      {super.key, required this.child, required this.fse, this.disabled});
  final Widget child;
  final Fse fse;
  final bool? disabled;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderBloc, FolderState>(
      builder: (context, state) {
        return ContextMenu(
          disabled: disabled,
          menuChildren: [
            SubmenuButton(
              child: Icon(Icons.add),
              menuChildren: [
                SizedBox(
                    width: 100,
                    child: TextField(
                      onSubmitted: (text) {
                        context.read<FolderBloc>().add(PrimaryActionHappened(
                            action: PrimaryAction.create, path: state.path+text));
                        // context
                        //     .read<FolderBloc>()
                        //     .add(ShowFolder(path: state.path));
                      },
                    ))
              ],
            ),
            // SubmenuButton(
            //   child: Icon(Icons.drive_file_rename_outline),
            //   menuChildren: [
            //     SizedBox(
            //         width: 100,
            //         child: TextField(
            //           onSubmitted: (text) {
            //             // context.read<FolderBloc>().add(ActionHappened(action: FseAction.rename, path: widget.fse.name, newPath: text));
            //           },
            //         ))
            //   ],
            // ),
            MenuItemButton(
              onPressed: () {
                context.read<FolderBloc>().add(PrimaryActionHappened(
                    action: PrimaryAction.delete, path: state.path+fse.name));
                // context.read<FolderBloc>().add(ShowFolder(path: state.path));
              },
              child: Icon(Icons.remove),
            ),
            // MenuItemButton(onPressed: () {}, child: Icon(Icons.copy)),
            // MenuItemButton(onPressed: () {}, child: Icon(Icons.cut)),
            // MenuItemButton(onPressed: () {}, child: Icon(Icons.paste)),
          ],
          child: child,
        );
      },
    );
  }
}
