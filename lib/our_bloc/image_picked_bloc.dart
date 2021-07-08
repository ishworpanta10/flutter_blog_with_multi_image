import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickedBloc extends Bloc<PickedFile?, List<PickedFile>> {
  ImagePickedBloc() : super([]);

  @override
  Stream<List<PickedFile>> mapEventToState(PickedFile? event) async* {
    if (event != null) {
      final oldState = state;
      if (oldState.isNotEmpty) {
        oldState.add(event);
        yield [...oldState];
      } else {
        yield [event];
      }
    } else {
      yield [];
    }
  }
}
