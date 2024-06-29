part of 'image_picker_bloc.dart';

@freezed
class ImagePickerState with _$ImagePickerState {
  const factory ImagePickerState.initial() = _Initial;
  const factory ImagePickerState.picking() = _Picking;
  const factory ImagePickerState.picked(File image) = _Picked;
  const factory ImagePickerState.error(String message) = _Error;
  const factory ImagePickerState.cleared() = _Cleared;
}
