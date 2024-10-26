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

final class CreateFolder extends FolderEvent {}

final class DeleteFolder extends FolderEvent {}

final class RenameFolder extends FolderEvent {}

final class WatchFolder extends FolderEvent {}

final class ExistsFolder extends FolderEvent {}


final class RequestToShowFile extends FolderEvent {
  const RequestToShowFile({required this.name, required this.path, required this.type});

  final String name;
  final String path;
  final String type;
}