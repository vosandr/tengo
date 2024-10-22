import 'dart:async';
import 'dart:io';
// import 'dart:developer';
// import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tengo_simple/repositories/folder_page/folder_repository.dart';
// import 'package:meta/meta.dart';
// import 'package:tengo_simple/repositories/folder_page/folder_repository.dart';
import 'package:tengo_simple/repositories/fse/fse_repository.dart';

part 'folder_view_event.dart';
part 'folder_view_state.dart';

class FolderViewBloc extends Bloc<FolderViewEvent, FolderViewState> {
  FolderViewBloc({required FolderRepository folderRepository})
      : _folderRepository = folderRepository,
        super(const FolderViewState()) {
    _setupEventHandlers();
  }

  final FolderRepository _folderRepository;

  Future<void> _onSubscriptionRequested(
    FolderViewSubscriptionRequested event,
    Emitter<FolderViewState> emit,
  ) async {
    emit(state.copyWith(status: () => FolderViewLoadingStatus.loading));

    await emit.forEach<FileSystemEntity>(
      _folderRepository.getFseListInFolder(path: event.path),
      onData: (fse) => state.copyWith(
        status: () => FolderViewLoadingStatus.success,
        fseList: () => _sort(
            fseList: state.fseList +
                [
                  _format(
                    fse: Fse(
                      name: fse.path,
                      type: fse.runtimeType.toString(),
                    ),
                  )
                ]),
      ),
      onError: (_, __) =>
          state.copyWith(status: () => FolderViewLoadingStatus.failure),
    );
  }
  
  Fse _format({required Fse fse}) {
    fse.name = fse.name.substring(fse.name.lastIndexOf('/')+1);
    if (fse.type == '_Directory') {
      fse.name += '/';
    }
    return fse;
  }

  List<Fse> _sort({required List<Fse> fseList}) {
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
    on<FolderViewSubscriptionRequested>(_onSubscriptionRequested);
  }
}
