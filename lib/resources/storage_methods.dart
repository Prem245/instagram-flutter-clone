import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadPicToStoarge(
      {required Uint8List imageFile,
      required bool isPost,
      required String childName}) async {
    // Path Reference to our profile pic storage
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(imageFile);

    TaskSnapshot snap = await uploadTask;

    // Download URL of our profile image
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
