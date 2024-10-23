part of 'file_bloc.dart';

sealed class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object> get props => [];
}

final class ShowFile extends FileEvent {
  const ShowFile({required this.fse});

  final Fse fse;
  @override
  List<Object> get props => [fse];
}

final class HideFile extends FileEvent {

}
