part of 'folder_view_bloc.dart';

sealed class FolderViewEvent extends Equatable {
  const FolderViewEvent();

  @override
  List<Object?> get props => [];
}


final class FolderViewSubscriptionRequested extends FolderViewEvent {
  const FolderViewSubscriptionRequested({this.path='./'});
  final String path;

  @override
  List<Object?> get props => [path];
}

final class FolderViewClearRequested extends FolderViewEvent {
  
}

final class FolderViewRefreshOccured extends FolderViewEvent {}

final class FolderViewCreateOccured extends FolderViewEvent {}

final class FolderViewDeleteOccured extends FolderViewEvent {}

final class FolderViewRenameOccured extends FolderViewEvent {}

final class FolderViewWatchOccured extends FolderViewEvent {}

final class FolderViewExistsOccured extends FolderViewEvent {}
