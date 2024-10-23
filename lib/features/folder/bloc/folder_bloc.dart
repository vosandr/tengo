import 'dart:async';
import 'dart:io';
// import 'dart:developer';
// import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tengo_simple/repositories/folder_page/folder_repository.dart';
// import 'package:meta/meta.dart';
// import 'paitories/folder_page/folder_repository.dart';
import 'package:tengo_simple/repositories/fse/fse_repository.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  FolderBloc({required FolderRepository folderRepository})
      : _folderRepository = folderRepository,
        super(const FolderState()) {
    _setupEventHandlers();
  }

  final FolderRepository _folderRepository;

  Future<void> _onShowFolder(
    ShowFolder event,
    Emitter<FolderState> emit,
  ) async {
    emit(state.copyWith(
      fseList: () => const [],
      status: () => FolderStatus.loading,
      path: () => _folderRepository.toAbsolute(path: event.path),
    ));
    await emit.forEach<FileSystemEntity>(
      _folderRepository.showFolderData(path: state.path),
      onData: (fse) => state.copyWith(
        status: () => FolderStatus.success,
        path: () => state.path,
        fseList: () => _sort(state.fseList +
            [
              _format(
                Fse(
                  name: fse.path,
                  type: fse.runtimeType.toString(),
                ),
              )
            ]),
      ),
      onError: (_, __) => state.copyWith(status: () => FolderStatus.failure),
    );
  }

  // Future<void> _onGoUp(GoUp event, Emitter<FolderState> emit) async {}

  _onHideFolder(HideFolder event, Emitter<FolderState> emit) {
    emit(
      state.copyWith(
        fseList: () => const [],
        // path: () => _folderRepository.toAbsolute(path: event.path)
      ),
    );
  }

  Fse _format(Fse fse) {
    fse.name = fse.name.substring(fse.name.lastIndexOf('/') + 1);
    if (fse.type == '_Directory') {
      fse.name += '/';
    }
    return fse;
  }

  List<Fse> _sort(List<Fse> fseList) {
    fseList.sort((a, b) {
      if (a.name.startsWith('.') && b.name.startsWith('.')) {
        return a.name.substring(1).compareTo(b.name.toLowerCase().substring(1));
      } else if (a.name.startsWith('.')) {
        return a.name.substring(1).compareTo(b.name.toLowerCase());
      } else if (b.name.startsWith('.')) {
        return a.name.compareTo(b.name.toLowerCase().substring(1));
      }
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return fseList;
  }

  void _setupEventHandlers() {
    on<ShowFolder>(_onShowFolder);
    on<HideFolder>(_onHideFolder);
  }
}
