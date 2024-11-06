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

final class RenameFile extends FileEvent {
  const RenameFile({
    required this.name,
    required this.newName,
    required this.path,
  });
  final String name;
  final String newName;
  final String path;
  @override
  List<Object> get props => [name, newName, path];
}

final class WriteFile extends FileEvent {
  const WriteFile({
    required this.name,
    required this.content,
    required this.path,
  });

  final String name;
  final String content;
  final String path;
  @override
  List<Object> get props => [name, path, content];
}
