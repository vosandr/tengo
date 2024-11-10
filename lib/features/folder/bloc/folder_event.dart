part of 'folder_bloc.dart';

sealed class FolderEvent extends Equatable {
  const FolderEvent();

  @override
  List<Object?> get props => [];
}

// final class ShowFolder extends FolderEvent {
//   const ShowFolder({this.path = ''});

//   final String path;

//   @override
//   List<Object?> get props => [path];
// }

final class PrimaryActionHappened extends FolderEvent {
  const PrimaryActionHappened({
    required this.action,
    required this.path,
  });
  final PrimaryAction action;
  final String path;
}

final class SecondaryActionHappened extends FolderEvent {
  const SecondaryActionHappened({required this.action, required this.path, required this.secondaryPath});

  final SecondaryAction action;
  final String path;
  final String secondaryPath;
}
// final class GoToFolder extends FolderEvent {
//   const GoToFolder({this.path = ''});

//   final String path;

//   @override
//   List<Object?> get props => [path];
// }

// final class RefreshFolder extends FolderEvent {
//   const RefreshFolder({this.path = ''});

//   final String path;

//   @override
//   List<Object?> get props => [path];
// }
