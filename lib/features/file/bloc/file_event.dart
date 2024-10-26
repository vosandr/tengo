part of 'file_bloc.dart';

sealed class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object> get props => [];
}

final class ShowFile extends FileEvent {
  const ShowFile({required this.name, required this.path});

  final String name;
  final String path;
  @override
  List<Object> get props => [name, path];
}

final class HideFile extends FileEvent {}

final class WaitRequestFileData extends FileEvent{}