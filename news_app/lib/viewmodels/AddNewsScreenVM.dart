import 'dart:async';
import 'dart:io';

import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/viewmodels/BaseViewModel.dart';

import 'package:image_picker/image_picker.dart';

class AddNewsScreenVM extends BaseViewModel {
  late MyFireBaseDatabase _db;
  String imageFileLink = '';

  bool isShowingProgress = false;

  initialise() {
    _db = MyFireBaseDatabase();
  }

  Future<bool> addNewsRecordToFirebaseDB(NewsModel newsModel) {
    return _db.addEntryToFireBase(newsModel);
  }

  Future<String> uploadImageToFirebase(File file) async {
    notifyChange();
    isShowingProgress = true;
    return _db.uploadImageToFirebase(file);
  }

  shouldShowProgress(bool value) {
    notifyChange();
    isShowingProgress = value;
  }

  //MR: pick image from gallery and upload to fire storage
  pickImageFromGallery() async {
    log('pickImageFromGallery');
    final PickedFile? pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    log('picked file path = ${pickedFile!.path}');

    await uploadImageToFirebase(File(pickedFile.path)).then((value) =>
        {
          notifyListeners(),
          print('value is $value'),
          imageFileLink = value,
        }
        );
  }
}
