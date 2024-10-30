part of 'folder_bloc.dart';

enum FolderStatus { initial, loading, success, sorted, failure }

final class FolderState extends Equatable {
  const FolderState({
    this.status = FolderStatus.initial,
    this.path = '',
    this.fseList = const [],
  });

  final FolderStatus status;
  final String path;
  final List<Fse> fseList;

  FolderState copyWith({
    FolderStatus Function()? status,
    String Function()? path,
    List<Fse> Function()? fseList,
  }) {
    return FolderState(
      status: status != null ? status() : this.status,
      path: path != null ? path() : this.path,
      fseList: fseList != null ? fseList() : this.fseList,
    );
  }

  @override
  List<Object?> get props => [status, path, fseList];
}
