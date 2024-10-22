part of 'folder_view_bloc.dart';

enum FolderViewLoadingStatus { initial, loading, success, failure }

final class FolderViewState extends Equatable {
  const FolderViewState({
    this.status = FolderViewLoadingStatus.initial,
    this.fseList = const [],
  });

  final FolderViewLoadingStatus status;
  final List<Fse> fseList;

  FolderViewState copyWith({
    FolderViewLoadingStatus Function()? status,
    List<Fse> Function()? fseList,
  }) {
    return FolderViewState(
      status: status != null ? status() : this.status,
      fseList: fseList != null ? fseList() : this.fseList,
    );
  }




  @override
  List<Object?> get props => [status, fseList];
}
