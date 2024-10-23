part of 'file_bloc.dart';

enum FileStatus { initial, loading, success, failure }

final class FileState extends Equatable {
  const FileState({this.status = FileStatus.initial, this.name=''});

  final FileStatus status;
  final String name;

  FileState copyWith({
    FileStatus Function()? status,
    String Function()? name,
  }) {
    return FileState(
      status: status != null ? status() : this.status,
      name: name != null ? name() : this.name,
    );
  }

  @override
  List<Object> get props => [status, name];
}

// final class FileViewInitial extends FileViewState {}
