part of 'file_bloc.dart';

enum FileStatus { initial, loading, success, failure }

final class FileState extends Equatable {
  const FileState(
      {this.status = FileStatus.initial,
      this.name = '',
      this.path = '',
      this.content = '',
      this.selection});

  final FileStatus status;
  final String name;
  final String path;
  final String content;
  final TextSelection? selection;

  FileState copyWith({
    FileStatus Function()? status,
    String Function()? name,
    String Function()? path,
    String Function()? content,
  }) {
    return FileState(
      status: status != null ? status() : this.status,
      name: name != null ? name() : this.name,
      path: path != null ? path() : this.path,
      content: content != null ? content() : this.content,
    );
  }

  @override
  List<Object> get props => [status, name, path, content];
}

// final class FileViewInitial extends FileViewState {}
