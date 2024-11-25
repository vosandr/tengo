part of 'folder_bloc.dart';

enum FolderStatus { initial, loading, success, sorted, failure }

final class FolderState extends Equatable {
  const FolderState({
    this.status = FolderStatus.initial,
    this.path = '',
    this.fseList = const [],
    this.textFieldEnabled = false,
    // this.additionalMessages=const []
  });

  final FolderStatus status;
  final String path;
  final List<Fse> fseList;
  final bool textFieldEnabled;
  // final List<String> additionalMessages;
  FolderState copyWith({
    FolderStatus Function()? status,
    String Function()? path,
    List<Fse> Function()? fseList,
    bool Function()? textFieldEnabled,
    // List<String> Function()? additionalMessages
  }) {
    return FolderState(
      status: status != null ? status() : this.status,
      path: path != null ? path() : this.path,
      fseList: fseList != null ? fseList() : this.fseList,
      textFieldEnabled:
          textFieldEnabled != null ? textFieldEnabled() : this.textFieldEnabled,
      // additionalMessages: additionalMessages!=null?additionalMessages():this.additionalMessages,
    );
  }

  @override
  List<Object?> get props => [status, path, fseList, textFieldEnabled];
}

class PasteState {
  const PasteState({this.currentPath, this.newPath});

  final String? currentPath;
  final String? newPath;
}
// class ActionState extends Equatable {
//   const ActionState({});

//   @override
//   // TODO: implement props
//   List<Object?> get props =>  [];
// }