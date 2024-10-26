import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';

class FolderContextMenu extends StatelessWidget {
  const FolderContextMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericContextMenu(buttonConfigs: [
      ContextMenuButtonConfig(
        '',
        onPressed: () {},
        icon: const Icon(Icons.drive_file_rename_outline),
      ),
      ContextMenuButtonConfig(
        '',
        onPressed: () {},
        icon: const Icon(Icons.copy),
      ),
      ContextMenuButtonConfig(
        '',
        onPressed: () {},
        icon: const Icon(Icons.cut),
      ),
      ContextMenuButtonConfig(
        '',
        onPressed: () {},
        icon: const Icon(Icons.delete),
      ),
    ]);
  }
}