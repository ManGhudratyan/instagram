part of 'media_bloc.dart';

sealed class MediaState extends Equatable {
  const MediaState({this.error, this.fileImage});
  final String? error;
  final FileImage? fileImage;
  @override
  List<Object?> get props => [error, fileImage];
}

final class MediaInitial extends MediaState {}

final class MediaLoading extends MediaState {}

final class MediaLoaded extends MediaState {
  MediaLoaded(FileImage? fileImage, MediaState initState)
      : super(fileImage: initState.fileImage);
}

final class MediaFailed extends MediaState {
  const MediaFailed(String error) : super(error: error);
}
