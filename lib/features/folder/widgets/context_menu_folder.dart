import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    hide SubmenuButton, MenuController, MenuAnchor, MenuItemButton;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengo/features/folder/bloc/folder_bloc.dart';
import 'package:tengo/main.dart';
// import 'package:tengo/open_source/menu_anchor.dart';
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
          menuMode: ContextMenuMode.secondaryKey,
          disabled: disabled,
          menuChildren: [
            IconButton(
              onPressed: () {
                context.read<FolderBloc>().add(PrimaryActionHappened(
                    action: PrimaryAction.delete, path: fse.name));
                // context.read<FolderBloc>().add(PrimaryActionHappened(
                //     action: PrimaryAction.read, path: state.path));
              },
              icon: const Icon(Icons.remove),
            ),
          ],
          child: child,
        );
      },
    );
  }
}
