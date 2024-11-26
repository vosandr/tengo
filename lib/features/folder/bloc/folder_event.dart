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
final class ChangePathEvent extends FolderEvent {
  const ChangePathEvent({required this.path});
  final String path;
}

final class PrimaryActionHappened extends FolderEvent {
  const PrimaryActionHappened({
    required this.action,
    required this.path,
  });
  final PrimaryAction action;
  final String path;
}

enum BooleanVar {
  textFieldEnabled,
}

final class BooleanVarChanged extends FolderEvent {
  const BooleanVarChanged({
    required this.booleanVar,
    required this.value,
  });
  final BooleanVar booleanVar;
  final bool value;
}

final class ReadingLinksHappened extends FolderEvent {
  const ReadingLinksHappened({required this.path, required this.name});
  final String path;
  final String name;
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
