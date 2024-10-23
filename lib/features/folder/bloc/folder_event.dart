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

final class HideFolder extends FolderEvent {}

final class RefreshFolder extends FolderEvent {}

final class CreateFolder extends FolderEvent {}

final class DeleteFolder extends FolderEvent {}

final class RenameFolder extends FolderEvent {}

final class WatchFolder extends FolderEvent {}

final class ExistsFolder extends FolderEvent {}

final class TapFile extends FolderEvent {}