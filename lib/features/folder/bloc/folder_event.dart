part of 'folder_bloc.dart';

sealed class FolderEvent extends Equatable {
  const FolderEvent();

  @override
  List<Object?> get props => [];
}

final class ShowFolder extends FolderEvent {
  const ShowFolder({this.path = ''});

  final String path;

  @override
  List<Object?> get props => [path];
}

final class OnePathActionHappened extends FolderEvent {
  const OnePathActionHappened({
    required this.action,
    required this.path,
  });
  final OnePathAction action;
  final String path;
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
final class HideFolder extends FolderEvent {}

final class CreateFse extends FolderEvent {}

final class RenameFse extends FolderEvent {}

final class DeleteFse extends FolderEvent {}

final class WatchFolder extends FolderEvent {}

final class ExistsFolder extends FolderEvent {}
