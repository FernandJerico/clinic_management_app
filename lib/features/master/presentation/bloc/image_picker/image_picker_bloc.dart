import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';
part 'image_picker_bloc.freezed.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(const _Initial()) {
    on<_PickImage>((event, emit) async {
      emit(const ImagePickerState.picking());
      try {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          emit(ImagePickerState.picked(File(pickedFile.path)));
        } else {
          emit(const ImagePickerState.error('No image selected'));
        }
      } catch (e) {
        emit(ImagePickerState.error(e.toString()));
      }
    });

    on<_ClearImage>((event, emit) async {
      emit(const ImagePickerState.initial());
    });
  }
}
