import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Subimos imagen al storage de firebase, el método devuelve la url de la foto subida

Future<String> uploadImageToFirebase(File image, String publiTitle) async {
  final collection = 'images';
  await Firebase.initializeApp();
  final storage = FirebaseStorage.instance;
  var snapshot = await storage.ref()
    .child('$collection/$publiTitle')
    .putFile(image);
  var url = await snapshot.ref.getDownloadURL();
  print(url.toString());
  return url.toString();
}

